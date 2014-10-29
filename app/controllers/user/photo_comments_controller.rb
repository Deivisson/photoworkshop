class PhotoCommentsController < ApplicationController
  before_action :set_photo_comment, only: [:show, :edit, :update, :destroy]

  def index
    @photo_comments = PhotoComment.all
    respond_with(@photo_comments)
  end

  def show
    respond_with(@photo_comment)
  end

  def new
    @photo_comment = PhotoComment.new
    respond_with(@photo_comment)
  end

  def edit
  end

  def create
    @photo_comment = PhotoComment.new(photo_comment_params)
    @photo_comment.save
    respond_with(@photo_comment)
  end

  def update
    @photo_comment.update(photo_comment_params)
    respond_with(@photo_comment)
  end

  def destroy
    @photo_comment.destroy
    respond_with(@photo_comment)
  end

  private
    def set_photo_comment
      @photo_comment = PhotoComment.find(params[:id])
    end

    def photo_comment_params
      params.require(:photo_comment).permit(:user_id, :photo_id, :content)
    end
end
