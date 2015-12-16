class User::HomeController < User::BaseController
	def index
		@photos = Photo.includes([:user => [:profile],:comments => [:user =>:profile]])
		@photos = @photos.paginate(page: params[:page], per_page: 7).order("created_at desc")
		@photographers_to_follow = current_user.suggest_to_follow
		@workshops = Workshop.to_promote(current_user.id)
		render layout:'user/home'
	end
end