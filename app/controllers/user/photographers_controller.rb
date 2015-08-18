class User::PhotographersController < User::BaseController
	before_action :set_user, only: [:follow,:unfollow,:show]

	def index
		@users = User.joins(:profile).where("users.id <> ?",current_user.id)
		if params[:search].present?
			@users = @users.where("user_profiles.user_name like ?","%#{params[:search]}%") 
		end
	end

	def show
		@photos = @user.photos.limit(10)
		@gallary_type = :table
	end

	def following
		@users = current_user.following
	end

	def followers
		@users = current_user.followers
	end

	def follow
		if !@user.nil?
			current_user.user_relations << UserRelation.new(user_followed_id:@user.id)
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

end