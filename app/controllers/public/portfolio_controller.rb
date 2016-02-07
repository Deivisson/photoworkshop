class Public::PortfolioController < ApplicationController
	layout 'public/photographer_portfolio'
	before_action :get_user_by_user_name, except: [:get_photo]
	before_action :get_portfolio_template, only: [:index, :get_photo]
	before_action :get_settings, only: [:index, :get_photo] 
	
	def index
		
	end

	def get_photo
		@photo = Photo.find(params[:photo_id])
	end

	def about

	end

	def missing
		
	end
private 
	
	def get_user_by_user_name
		@photographer = User.joins(:profile).where("user_profiles.user_name = ?",params[:user_name]).first
	end

	def get_portfolio_template
		if params[:template]
			@portfolio_template = PortfolioTemplate.find(params[:template]) 
		else 
			@user_template = @photographer.active_user_portfolio_template
			unless @user_template.nil?
				@portfolio_template = @user_template.template
			end
		end
		render :missing if @portfolio_template.nil?
	end

	def get_settings
		@theme_color = params[:theme_color] || "dark"
		unless @user_template.nil?
			settings = JSON.parse(@user_template.settings)
			@theme_color = settings["theme_color"]
		end
	end
end