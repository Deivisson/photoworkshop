class User::HomeController < User::BaseController
	def index
		@photos = Photo.all.order("created_at desc")
		@photographers_to_follow = User.all.limit(3)
	end
end