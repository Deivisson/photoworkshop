class Public::PhotographersController < Shared::PhotographersController
	before_action :set_namespace
 	def show
		super
		render layout:'public/photographer_profile'
 	end

private
	
	def set_namespace
		@namespace = :public	 		
 	end 	
end