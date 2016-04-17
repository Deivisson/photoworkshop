module User::CommunicationsHelper
	def communication_message
		return if @communication.nil?
		if @communication.id == 1
			html = hidden_field_tag :communication,@communication.id,
					                     id:'communication_tag',
					                     href:user_communication_path(@communication) 
		else
			html = content_tag(:div,id:"communication-alert-message") do
				render("user/communications/partials/#{@communication.partial_name}")
			end
			html
		end
	end
end