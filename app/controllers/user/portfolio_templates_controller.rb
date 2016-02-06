class User::PortfolioTemplatesController < User::BaseController
	before_action :set_photographer, :get_template

	def index
		@theme = params[:layout_theme] || ""
		session[:layout_theme] = @theme
	end

	def preview
		@theme = params[:layout_theme] || ""
	end

	def buy
		current_user.buy_portfolio_template!(@portfolio_template)
	end

private
	def set_photographer
		@photographer = current_user
	end

	def get_template
		@portfolio_template = if params[:template]
														PortfolioTemplate.find(params[:template])
													else
														PortfolioTemplate.first
													end
	end
end