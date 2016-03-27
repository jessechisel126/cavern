include WaveFile

class UploadController < ApplicationController
  $file_name = nil
  $data = []
  $positive_points = []
  $negative_points = []

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
    # @uploader = AudioFileUploader.new
    # @uploader.retrieve_from_store!($file_name)

    reader = Reader.new($file_name)
    $data = $subset_data = []
    begin
      while true do
        buffer = reader.read(4096)
        $data += buffer.samples
        puts "Read #{buffer.samples.length} samples."
      end
    rescue EOFError
      reader.close
    end

    $positive_points = $data.map { |x| (x < 0) ? 0 : x }
    $negative_points = $data.map { |x| (x > 0) ? 0 : x }

    $positive_points = UploadHelper::partition($positive_points, 1000)
        .map { |a| UploadHelper::average_list(a) }
    $negative_points = UploadHelper::partition($negative_points, 1000)
        .map { |a| UploadHelper::average_list(a) }

    redirect_to '/upload/show'
  end

  def show
    @uploader = AudioFileUploader.new
    @uploader.retrieve_from_store!($file_name)
  end
end
