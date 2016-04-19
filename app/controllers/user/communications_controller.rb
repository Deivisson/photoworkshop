class User::CommunicationsController < User::BaseController
	before_action :set_communication
	
	def show		
	end

	def create
		unless @communication.nil?
			current_user.communications << @communication
			case @communication.id
			when 1
				current_user.update_attribute(:refuse_eduk_award,true) if params[:tag] == "refuse"
			when 2
				redirect_to edit_user_profile_path(current_user) unless request.xhr?
			end
		end
	end

private
	def set_communication
		@communication = Communication.find(params[:id])
	end
end