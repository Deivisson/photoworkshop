class User::PhotoLikesController < User::BaseController
	before_action :set_photo 

	def like
		if !@photo.nil? && !@photo.admirer_ids.include?(current_user.id)
			current_user.liked_photos << @photo	
			@likes_count = @photo.likes.count
		end
	end

	def unlike
		if !@photo.nil? && @photo.admirer_ids.include?(current_user.id)
			current_user.photo_likes.where(photo_id:@photo.id).first.destroy	
			@likes_count = @photo.likes.count
		end
	end

private

	def set_photo
    @photo = current_user.photos.find(params[:photo_id])
	end
end