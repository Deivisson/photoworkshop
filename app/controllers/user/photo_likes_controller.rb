class User::PhotoLikesController < User::BaseController
	before_action :set_photo 

	def like
		if !@photo.nil? && !@photo.liker_ids.include?(current_user.id)
			photo_like = @photo.likes.build(user_id:current_user.id)
			photo_like.save
			@likes_count = @photo.likes_count
		end
	end

	def unlike
		if !@photo.nil? && @photo.liker_ids.include?(current_user.id)
			photo_like = @photo.likes.where("photo_id = ? and user_id = ?",@photo.id,current_user.id).first
			unless photo_like.nil?
				photo_like.destroy
				@likes_count = @photo.likes_count
			end
		end
	end

private

	def set_photo
    @photo = Photo.find(params[:photo_id])
	end
end