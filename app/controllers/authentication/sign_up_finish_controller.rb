class Authentication::SignUpFinishController < ApplicationController
  def complete_sign_up
    auth_params = {
      provider:   params["auth"]["auth_provider"],
      uid:        params["auth"]["auth_uid"],
      email:      params["auth"]["email"],
      full_name:  params["auth"]["full_name"],
      user_name:  params["auth"]["user_name"],
      avatar_url: params["auth"]["auth_avatar_url"]
    }
    puts "Authentication::SignUpFinishController => #{auth_params}"
		@user = User.from_omniauth(auth_params)
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      #set_flash_message(:notice, :success, :kind => "twitter") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end    
  end
end
