class Home::UserProfileController < Home::BaseController
	
	def format_user_name
		@user_name = UserProfile.get_user_name(params[:full_name])
		@user_name = "" unless UserProfile.where(user_name:@user_name).first.nil?
		respond_to do |format|
    	format.js
  	end
	end

	def check_user_name
		@valid_user_name = false
		user_profile = UserProfile.where(user_name:params[:user_name]).first
		if user_profile.nil?
			@valid_user_name = UserProfile.valid_user_name?(params[:user_name])
		end
		respond_to do |format|
    	format.js
  	end
	end
end