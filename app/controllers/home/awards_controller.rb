class Home::AwardsController < Home::BaseController
	layout 'home/awards'
	
	def index
		@award_name = params[:name]
	end
end