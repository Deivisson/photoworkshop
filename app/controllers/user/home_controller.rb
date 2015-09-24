class User::HomeController < User::BaseController
	#http://www.sitepoint.com/infinite-scrolling-rails-basics/
	def index
		@photos = Photo.paginate(page: params[:page], per_page: 15).order("created_at desc")
		@photographers_to_follow = User.all.limit(3)
	end
	#@posts = Post.paginate(page: params[:page], per_page: 15).order('created_at DESC')
end