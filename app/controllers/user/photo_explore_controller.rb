class User::PhotoExploreController < User::BaseController
	def index
		@photos 				= Photo.all.order("created_at desc")
		@photos				  = @photos.where(category_id:params["category_id"]) if params["category_id"].present?
		@gallary_type 	= params[:gallary_type] || "flow" 
		@categories			= Category.all
		render layout: "user/explorer"
	end

	def show
		@photo = Photo.find(params[:photo_id])
		@photo.update_views! if @photo.user_id != current_user.id
	end

end