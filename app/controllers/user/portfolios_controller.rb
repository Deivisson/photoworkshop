class User::PortfoliosController < User::BaseController
	before_action :set_photographer

	def index
		@portfolio_template = PortfolioTemplate.first
		@theme = params[:layout_theme] || ""
		session[:layout_theme] = @theme
	end

	def preview
		@portfolio_template = PortfolioTemplate.find(params[:template])
		@theme = params[:layout_theme] || ""
	end

	def buy_template
	end

private
	def set_photographer
		@photographer = current_user
	end
end