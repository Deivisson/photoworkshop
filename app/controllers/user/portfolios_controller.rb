class User::PortfoliosController < User::BaseController
	def index
		@photographer = current_user		
	end
end