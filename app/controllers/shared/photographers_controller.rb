class Shared::PhotographersController < ApplicationController
	before_action :set_user
	before_action :load_resources, only: [:index]
	before_action :get_photos, only: [:photos,:show]

	#For the index method, the @user is current user
	def index
		if params[:conditions].present? && params[:conditions][:state_id].present?
			@users = User.joins(:profile => :city)
		else
			@users = User.joins(:profile)
		end
		@users = @users.paginate(page: params[:page], per_page: 10)
		@users = @users.where("users.id <> ?",current_user.id)
		@users = @users.where("user_profiles.user_name like ?","%#{params[:search]}%") if params[:search].present?
		if params[:conditions].present?
			@users = @users.where("cities.state_id = ?", params[:conditions][:state_id].to_i) if params[:conditions][:state_id].present?
			@users = @users.where("user_profiles.city_id = ?", params[:conditions][:city_id].to_i) if params[:conditions][:city_id].present?
			@users = @users.where("user_profiles.available_for_employment = true") if params[:conditions][:available_for_employment].present?
			@users = @users.where("user_profiles.available_for_freelance = true") if params[:conditions][:available_for_freelance].present?
		end
		@users = @users.where("user_profiles.category_id = ?", params[:category_id]) if params[:category_id].present?
		@paging = params[:page].present?
		@current_menu = "photographers"
		render layout:'user/explorer'
	end

	#For the show, photos, following and followers methods, the @user is the user that is showing
	def show
		if request.xhr?
			@gallary_type = :table;@modal_view = true 
		else
			@gallary_type = :flow;@modal_view = false
		end
	end

	def photos
		@gallary_type = :flow
	end

	def following
		@users = @user.following
	end

	def followers
		@users = @user.followers
	end

	def about
		@user_profile = @user.profile
	end

	def workshops
		@workshops = @user.owner_workshops.order(created_at: :desc)
	end

	#For the follow and unfollow methods, the @user is the user that is being or stopping followed
	def follow
		if !@user.nil?
			current_user.user_relations << UserRelation.new(user_followed_id:@user.id)
			@photographers_to_follow = current_user.suggest_to_follow
		end
	end

	def unfollow
		if !@user.nil?
			user_relation = current_user.user_relations.where(user_followed_id:@user.id).first
			user_relation.destroy unless user_relation.nil?
		end
	end

private 

	def set_user
		if action_name == "index" && !current_user.nil?
			@user = current_user
		else
			if params[:user_name] #call from access route pic2gether/:user_name. E.: Public routes
				@user = User.joins(:profile).where("user_profiles.user_name = ?",params[:user_name]).first 
			elsif params[:photographer_id].present? || params[:id].present?
				@user = User.find(params[:photographer_id].nil? ? params[:id] : params[:photographer_id])
			end
		end
	end

	def get_photos
		@photos = @user.photos.limit(16)
	end

	def load_resources
		@categories	= Category.all
    @states = State.all
    @cities =  []
	end
end