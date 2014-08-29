class User::PhotoLikesController < User::BaseController
	before_action :set_photo 

	def like
		current_user.liked_photos << @photo	unless @photo.nil?
	end

	def unlike
		current_user.photo_likes.where(photo_id:@photo.id).first.destroy	unless @photo.nil?
	end

private

	def set_photo
    @photo = current_user.photos.find(params[:photo_id])
	end
end