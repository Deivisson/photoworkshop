class Public::PhotoController < ApplicationController
	layout 'public/photo_view'
	def show
    @photo_comment = PhotoComment.new
		@photo = Photo.find(params[:id])
		@photo.update_views!(current_user,request.remote_ip)
	end
end