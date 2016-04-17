module User::MessageHelper

	def toolbar_message_button
		html = []
		html << link_to_message(current_user.unseen_messages_count) do
			inner_html = []
			inner_html << content_tag(:span,class:'bubble-count', id:'message-bubble-count') do
				current_user.unseen_messages_count.to_s.html_safe
			end if current_user.unseen_messages_count > 0 
			inner_html << content_tag(:span,"", class:"icon20 message")
			inner_html.join.html_safe
		end
		html << render("user/messages/resume_menu")
		html.join.html_safe
	end

	def link_to_message(unread_count, &block)
		url = (unread_count >0) ? user_reset_unseen_messages_count_path : "#"
		link_to(url, data:{remote:(unread_count >0),method: :put}, class:"messages-icon", id:'messages-menu-trigger',&block)
	end

	def message_button_tag
		html = []
		html << content_tag(:li) do 
			inner_html = []
			inner_html << link_to(new_user_message_path(user_receiver_id:@user.id), remote:true,
											class:'common-button only-icon message-button',id:'message-send-button') do
				content_tag(:span, "",class:"icon20pb message")
			end
			inner_html.join.html_safe
		end
		html.join.html_safe
	end
end
