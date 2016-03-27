include WaveFile

NUM_PARTITIONS = 1000
THRESHOLD = 0.05

class UploadController < ApplicationController
  $file_name = nil
  $channels = nil
  $data = []
  $positive_points = []
  $negative_points = []
  $peak_ranges = []

  def new
  end

  def create
    @uploader = AudioFileUploader.new

    file = params[:file]
    if file.nil? or not @uploader.extension_white_list.include? File.extname(file.path)[1..-1]
      flash[:danger] = "Please upload a valid file."
      redirect_to '/'
    else
      # Store the file
      @uploader.store! file
      # UploadHelper::read_file(params[:upload][:file].original_filename)
      $file_name = Rails.root + @uploader.path
      redirect_to '/upload/loading'
    end
  end

  def loading
    $channels = nil
    reader = Reader.new($file_name)
    $data = $peak_ranges = $positive_points = $negative_points = []
    begin
      while true do
        buffer = reader.read(4096)
        $channels ||= buffer.channels
        $data += buffer.samples
        puts "Read #{buffer.samples.length} samples."
      end
    rescue EOFError
      reader.close
    end

    if $channels > 1
      $data = $data.map { |x| x[0] }
    end

    $positive_points = $data.map { |x| 
      (x < 0) ? 0 : x 
    }
    $negative_points = $data.map { |x| 
      (x > 0) ? 0 : x 
    }

    $positive_points = UploadHelper::partition($positive_points, NUM_PARTITIONS)
        .map { |a| UploadHelper::average_list(a) }
    $negative_points = UploadHelper::partition($negative_points, NUM_PARTITIONS)
        .map { |a| UploadHelper::average_list(a) }

    # First we run through our positive_points array and find the global_max
    global_max = 0
    $positive_points.each { 
      |element| global_max = (element > global_max) ? element : global_max 
    }

    # After we have our global max, we compare it to a threshold defined
    # as a constant where elements that are above global_max * THRESHOLD
    # can be added to our $peak_ranges
    $peak_ranges = []
    beat_range = []
    $positive_points.each_with_index do |element, i|
      if element >= (global_max * THRESHOLD)
        beat_range << i
      else 
        $peak_ranges << [beat_range[0], beat_range[-1]] unless beat_range.length < 2
        beat_range = []
      end
    end

    # Since we may leave our check for maximums ON a maximum, we check our
    # beat_range one more time verifying whether or not it's a peak range
    $peak_ranges << [beat_range[0], beat_range[-1]] unless beat_range.length < 2

    redirect_to '/upload/show'
  end

  def show
    @uploader = AudioFileUploader.new
    @uploader.retrieve_from_store!($file_name)
  end
end
