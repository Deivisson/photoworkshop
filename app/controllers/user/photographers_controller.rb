class User::PhotographersController < Shared::PhotographersController
	before_action :authenticate_user!, :set_namespace
	layout 'user/dashboard' 
	
	def show
		super
		render layout:'user/show_photographer'
	end

private
	def set_namespace
		@namespace = :user	 		
 	end 
end