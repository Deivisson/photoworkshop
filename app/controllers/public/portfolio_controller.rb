class Public::PortfolioController < ApplicationController
	layout 'public/photographer_portfolio'
	def index
		@photographer = get_user_by_user_name
		@layout = params[:layout]
		@theme = params[:layout_theme] || ""
	end
	def get_photo
		@photo = Photo.find(params[:photo_id])
	end

private 
	
	def get_user_by_user_name
		User.find(params[:user_id])
	end
end