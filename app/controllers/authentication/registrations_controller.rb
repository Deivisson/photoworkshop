class Authentication::RegistrationsController < Devise::RegistrationsController
		before_filter :update_sanitized_params, if: :devise_controller?

    #This 2 lines avoid this error PG::InFailedSqlTransaction in Authentication::RegistrationsController#create 
    skip_before_filter :require_no_authentication
  	before_filter :authenticate_user!

    def update_sanitized_params
       #devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:full_name, :user_name ,:email, :password, :password_confirmation)}
       devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :user_name ,:email, :password, :password_confirmation])
    end
end