class User::PhotographersController < User::BaseController
	before_action :set_user, except: [:index]
	before_action :get_photos, only: [:photos,:show]

	def index
		@users = User.joins(:profile).where("users.id <> ?",current_user.id)
		if params[:search].present?
			@users = @users.where("user_profiles.user_name like ?","%#{params[:search]}%") 
		end
		if params[:category_id].present?
			@users = @users.where("user_profiles.category_id = ?", params[:category_id])
		end
		@categories	= Category.all
		render layout:'user/explorer'
	end

	def show
		if request.xhr?
			@gallary_type = :table
			@modal_view = true 
		else
			@gallary_type = :flow
			@modal_view = false
		end
		render layout:'user/show_photographer'
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
		@user = User.find(params[:photographer_id].nil? ? params[:id] : params[:photographer_id])
	end

	def get_photos
		@photos = @user.photos.limit(10)
	end
end