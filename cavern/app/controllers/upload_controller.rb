class UploadController < ApplicationController

  def new
  end

  def create
    @uploader = AudioFileUploader.new

    # Store the file
    @uploader.store! params[:upload][:file]

    redirect_to '/'
  end

end
