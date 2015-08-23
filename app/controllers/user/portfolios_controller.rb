class User::PortfoliosController < User::BaseController
	before_action :set_photographer

	def index
		@layout = "horizontal_slide"
		@theme = params[:layout_theme] || ""
		session[:layout_theme] = @theme
	end

	def preview
		@layout = params[:layout]
		@theme = params[:layout_theme] || ""
	end

private
	def set_photographer
		@photographer = current_user
	end
end