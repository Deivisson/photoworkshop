class User::PhotoExploreController < User::BaseController
	def index
		@photos	= Photo.all.order("created_at desc")
		@photos = @photos.where(category_id:params["category_id"]) if params["category_id"].present?
		if params[:search]
			@photos = @photos.where("(title ~* :str) or (description ~* :str) or (tags ~* :str)", str: "#{params[:search]}")
		end

		if params[:exif_fields]
			@photos = @photos.joins(:exif)
			@photos = @photos.where("photo_exifs.maker ~* ?",params[:exif_fields]["maker"]) if params[:exif_fields]["maker"].present?
			@photos = @photos.where("photo_exifs.model ~* ?",params[:exif_fields]["model"]) if params[:exif_fields]["model"].present?
			@photos = @photos.where("photo_exifs.aperture ~* ?",params[:exif_fields]["aperture"]) if params[:exif_fields]["aperture"].present?
			@photos = @photos.where("photo_exifs.focal_lenght ~* ?",params[:exif_fields]["focal_lenght"]) if params[:exif_fields]["focal_lenght"].present?
			@photos = @photos.where("photo_exifs.iso = ?",params[:exif_fields]["iso"]) if params[:exif_fields]["iso"].present?
			@photos = @photos.where("photo_exifs.shutter_speed ~* ?",params[:exif_fields]["shutter_speed"]) if params[:exif_fields]["shutter_speed"].present?
		end

		@gallary_type 	= params[:gallary_type] || "flow" 
		@categories			= Category.all
		render layout: "user/explorer"
	end

	def show
    @photo_comment = PhotoComment.new
		@photo = Photo.find(params[:photo_id])
		@photo.update_views!(current_user,request.remote_ip)
	end

end