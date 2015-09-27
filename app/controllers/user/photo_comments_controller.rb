class User::PhotoCommentsController < User::BaseController
  before_action :set_photo, only: [:create, :destroy]
  before_action :set_photo_comment, only: [:destroy]
  
  def create
    @photo_comment = @photo.comments.build(photo_comment_params.merge(user_id:current_user.id))
    @photo_comment.save
  end

  def destroy
    @photo_comment.destroy
  end

  private
    def set_photo
      @photo = Photo.find(params[:photo_id])  
    end

    def set_photo_comment
      if @photo.user_id == current_user.id 
        #Allow the photo owner delete the any comments
        @photo_comment = @photo.comments.find(params[:id])
      else
        #If the current user is not the owner, just allow destroy comments made by it self
        @photo_comment = current_user.photo_comments.where("id = ? and photo_id = ? ",params[:id],params[:photo_id]).first  
      end
    end

    def photo_comment_params
      params.require(:photo_comment).permit(:content)
    end
end
