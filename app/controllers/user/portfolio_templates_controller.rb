class User::PortfolioTemplatesController < User::BaseController
	before_action :set_photographer, :get_template

	def index
		@theme_color = params[:theme_color] || "dark"
		session[:theme_color] = @theme_color
	end

	def preview
		@theme_color = params[:theme_color] || "dark"
	end

	def buy
		settings = {:theme_color => (params[:theme_color] || "dark")}
		current_user.buy_portfolio_template!(@portfolio_template,settings.to_json)
	end

private
	def set_photographer
		@photographer = current_user
	end

	def get_template
		@portfolio_template = if params[:template] || params[:portfolio_template_id]
														PortfolioTemplate.find(params[:template] || params[:portfolio_template_id])
													else
														PortfolioTemplate.first
													end
	end
end