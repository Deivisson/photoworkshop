require "application_responder"
class User::BaseController < ApplicationController
  self.responder = ApplicationResponder
  respond_to :html,:json

	before_action :authenticate_user!
	layout 'user/dashboard'
end