class User::PortfoliosController < User::BaseController
	before_action :set_photographer

	def index
	end

	def preview
		@layout = params[:layout]
	end

private
	def set_photographer
		@photographer = current_user
	end
end