class Authentication::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def providers
    auth = request.env["omniauth.auth"]
    auth_params = {
      provider:   auth.provider,
      uid:        auth.uid,
      email:      auth.info.email,
      full_name:  auth.info.name,
      user_name:  auth.info.name,
      avatar_url: get_avatar_url(auth),
      account_url: get_account_url(auth)
    }
    @user = User.from_omniauth(auth_params)
    puts @user.valid?
    puts @user.errors.full_messages
    puts @user.persisted? 
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => auth.provider) if is_navigational_format?
    else
      render :sign_finish
    end
  end

   alias_method :facebook, :providers
   alias_method :twitter, :providers
   alias_method :google_oauth2, :providers
   
 private

  def get_account_url(auth)
    url = ""
    if auth.provider == "twitter"
      url = auth.info.urls.Twitter
    elsif auth.provider == "facebook"
      url = "https://www.facebook.com/#{auth.uid}"
    elsif auth.provider == "google_oauth2"
      url = auth.extra.raw_info.profile
    end
    url
  end

  def get_avatar_url(auth)
    url = ""
    if %w("twitter" "google_oauth2").include?(auth.provider) 
      url = auth.info.image
    elsif auth.provider == "facebook"
      url = "https://graph.facebook.com/#{auth.uid}/picture?type=large"
    end
    return url
  end
end
