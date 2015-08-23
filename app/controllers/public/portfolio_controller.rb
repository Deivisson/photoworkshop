class Public::PortfolioController < ApplicationController
	layout 'public/photographer_portfolio'
	def index
		@photographer = User.find(1)
		@layout = params[:layout]
		@theme = params[:layout_theme] || ""
	end
	def get_photo
		@photo = Photo.find(params[:photo_id])
	end
end