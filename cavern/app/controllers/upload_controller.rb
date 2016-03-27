include WaveFile

class UploadController < ApplicationController
  $file_name = nil
  $errors = nil

  def new
  end

  def create
    @uploader = AudioFileUploader.new

    file = params[:file]
    if file.nil? or not @uploader.extension_white_list.include? File.extname(file.path)[1..-1]
      $errors = "Please upload a valid file."
      redirect_to '/'
    else
      # Store the file
      @uploader.store! file
      # UploadHelper::read_file(params[:upload][:file].original_filename)
      $file_name = Rails.root + @uploader.path
      redirect_to '/upload/show' 
    end
  end

  def show
    @uploader = AudioFileUploader.new
    @uploader.retrieve_from_store!($file_name)
  end
end
