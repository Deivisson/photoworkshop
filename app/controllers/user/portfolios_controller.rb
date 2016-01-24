class User::PortfoliosController < User::BaseController
	before_action :set_photographer

	def index
		@portfolio = Portfolio.first
		@theme = params[:layout_theme] || ""
		session[:layout_theme] = @theme
	end

	def preview
		@portfolio = Portfolio.find(params[:portfolio])
		@theme = params[:layout_theme] || ""
	end

private
	def set_photographer
		@photographer = current_user
	end
end