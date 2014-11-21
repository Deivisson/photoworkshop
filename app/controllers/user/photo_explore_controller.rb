class User::PhotoExploreController < User::BaseController
	def index
		@photos 				= Photo.all.order("created_at desc")
		@gallary_type 	= params[:gallary_type] || "flow" 
	end

	def show
		@photo = Photo.find(params[:photo_id])
		@photo.update_views! if @photo.user_id != current_user.id
	end

end