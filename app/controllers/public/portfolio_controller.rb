class Public::PortfolioController < ApplicationController
	layout 'public/photographer_portfolio'
	
	def index
		@photographer = get_user_by_user_name
		@portfolio  	= get_portfolio
		@theme 				= params[:layout_theme] || ""
	end

	def get_photo
		@photo = Photo.find(params[:photo_id])
	end

private 
	
	def get_user_by_user_name
		if params["user_name"]
			User.joins(:profile).where("user_profiles.user_name = ?",params[:user_name]).first
		else
			User.find(params[:user_id])
		end
	end

	def get_portfolio
		if params[:portfolio]
			Portfolio.find(params[:portfolio]) 
		else 
			Portfolio.first
		end
	end
end