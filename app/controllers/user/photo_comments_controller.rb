class User::PhotoCommentsController < User::BaseController
  before_action :set_photo_comment, only: [:destroy]
  before_action :set_photo, only: [:create]


  def create
    @photo_comment = @photo.comments.build(photo_comment_params.merge(user_id:current_user.id))
    @photo_comment.save
    puts @photo_comment.errors.full_messages
  end

  def destroy
    @photo_comment.destroy
  end

  private
    def set_photo
      @photo = current_user.photos.find(params[:photo_id])  
    end

    def set_photo_comment
      @photo_comment = PhotoComment.find(params[:id])
    end

    def photo_comment_params
      params.require(:photo_comment).permit(:content)
    end
end
