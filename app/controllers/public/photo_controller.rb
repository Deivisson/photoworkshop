class Public::PhotoController < ApplicationController
	layout 'public/photo_view'
	def show
    @photo_comment = PhotoComment.new
		@photo = Photo.find(params[:id])
		@photo.update_views! if (current_user.nil? || @photo.user_id != current_user.id)
	end
end