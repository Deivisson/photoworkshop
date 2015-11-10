class User::PhotographersController < User::BaseController
	before_action :set_user
	before_action :get_photos, only: [:photos,:show]

	#For the index method, the @user is current user
	def index
		@users = User.joins(:profile).paginate(page: params[:page], per_page: 30)
		@users = @users.where("users.id <> ?",current_user.id)
		if params[:search].present?
			@users = @users.where("user_profiles.user_name like ?","%#{params[:search]}%") 
		end
		if params[:category_id].present?
			@users = @users.where("user_profiles.category_id = ?", params[:category_id])
		end
		@categories	= Category.all
		@paging = params[:page].present?
		render layout:'user/explorer'
	end

	#For the show, photos, following and followers methods, the @user is the user that is showing
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
		if action_name == "index"
			@user = current_user
		else
			@user = User.find(params[:photographer_id].nil? ? params[:id] : params[:photographer_id])
		end
	end

	def get_photos
		@photos = @user.photos.limit(16)
	end
end