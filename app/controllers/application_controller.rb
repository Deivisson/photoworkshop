require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private

  #Define layouts to devise sessions according resources
  # def layout_by_resource
  #   if devise_controller?
  #     case resource_name
  #       when :user, :customer_account, :professional_account
  #         "home/authentication"
  #       when :admin
  #         "admin/authentication"
  #     end
  #   end
  # end

  # Overwriting the sign_in redirect path method
  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope.class.to_s
      when "User"
        #valid_user_for_current_company?  ? company_root_path : new_user_session_path
        user_root_path
    end
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    case resource_or_scope
      when :user
        root_path
    end
  end

end
