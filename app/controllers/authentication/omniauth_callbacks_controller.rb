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
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      render :sign_finish
    end
  end

   alias_method :facebook, :providers
   alias_method :twitter, :providers

 private

  def get_account_url(auth)
    url = ""
    if auth.provider == "twitter"
      url = auth.info.urls.Twitter
    elsif auth.provider == "facebook"
      url = "https://www.facebook.com/#{auth.uid}"
    end
    url
  end

  def get_avatar_url(auth)
    url = ""
    if auth.provider == "twitter"
      url = auth.info.image
    elsif auth.provider == "facebook"
      url = "https://graph.facebook.com/#{auth.uid}/picture?type=large"
    end
    return url
  end
end
