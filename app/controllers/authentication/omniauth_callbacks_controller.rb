class Authentication::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def providers
    auth = request.env["omniauth.auth"]
    auth_params = {
      provider:   auth.provider,
      uid:        auth.uid,
      email:      auth.info.email,
      full_name:  auth.info.name,
      user_name:  auth.info.name,
      avatar_url: auth.info.image
    }
    @user = User.from_omniauth(auth_params)
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      #session["devise.facebook_data"] = request.env["omniauth.auth"]
      #redirect_to new_user_registration_url
      render :sign_finish
    end
  end

   alias_method :facebook, :providers
   alias_method :twitter, :providers

  # def twitter
  #   auth = request.env["omniauth.auth"]
  #   auth_params = {
  #     provider:   auth.provider,
  #     uid:        auth.uid,
  #     email:      auth.info.email,
  #     full_name:  auth.info.name,
  #     user_name:  auth.info.name,
  #     avatar_url: auth.info.image
  #   }    
  #   @user = User.from_omniauth(auth_params)
  #   if @user.persisted?
  #     sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
  #     set_flash_message(:notice, :success, :kind => "twitter") if is_navigational_format?
  #   else
  #     #session["devise.facebook_data"] = request.env["omniauth.auth"]
      
  #   end
  # end
  def sign_finish;  end
  # def complete_sign_up
  #   puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>oi"
  # end
end