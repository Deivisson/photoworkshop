class User::CommunicationsController < User::BaseController
	before_action :set_communication
	
	def show		
	end

	def create
		unless @communication.nil?
			current_user.communications << @communication
			current_user.update_attribute(:refuse_eduk_award,true) if params[:tag] == "refuse"
		end
	end

private
	def set_communication
		@communication = Communication.find(params[:id])
	end
end