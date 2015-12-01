class User::PhotoRatingsController < User::BaseController
	def index
		@rating_criteriums = RatingCriterium.all
		render layout:false
	end
end

