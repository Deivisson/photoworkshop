class Public::PortfolioController < ApplicationController
	layout 'public/photographer_portfolio'
	before_action :get_user_by_user_name, except: [:get_photo]
	before_action :get_portfolio_template, only: [:index, :get_photo]
	
	def index
			@theme = params[:layout_theme] || ""
	end

	def get_photo
		@photo = Photo.find(params[:photo_id])
	end

	def about

	end

private 
	
	def get_user_by_user_name
		#if params["user_name"]
		@photographer = User.joins(:profile).where("user_profiles.user_name = ?",params[:user_name]).first
		# else
		# 	@photographer = User.find(params[:user_id])
		# end
	end

	def get_portfolio_template
		@portfolio_template = if params[:template]
														PortfolioTemplate.find(params[:template]) 
													else 
														@photographer.active_portfolio_template
													end
	end
end