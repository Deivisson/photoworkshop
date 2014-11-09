class User::ExploreController < User::BaseController
	def index
		@photos = Photo.all.order("created_at desc")
	end
end