class User::RankingsController < User::BaseController
	def index
		@ranking_users = User.order("current_points desc")
		render layout:false
	end
end