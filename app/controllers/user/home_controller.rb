class User::HomeController < User::BaseController
	def index
		@photos = Photo.paginate(page: params[:page], per_page: 7).order("created_at desc")
		@photographers_to_follow = current_user.suggest_to_follow
	end
end