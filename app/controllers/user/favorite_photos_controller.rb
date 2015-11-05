class User::FavoritePhotosController < User::BaseController
	before_action :set_photo

	def favoritar
		@favorite_photo = current_user.favorite_photos.create!(photo_id:@photo.id)
	end

	def unfavoritar
		@favorite_photo =	current_user.favorite_photos.where(photo_id:@photo.id).first
		@favorite_photo.destroy unless @favorite_photo.nil?
	end

private 

	def set_photo
		@photo = Photo.find(params[:photo_id])
	end
end
