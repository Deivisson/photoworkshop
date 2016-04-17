module User::NotificationHelper
	def toolbar_notification_button
		html = []
		html << link_to_notification(current_user.unseen_notifications_count) do
			innerHtml = []
			innerHtml << content_tag(:span,class:'bubble-count', id:'notification-bubble-count') do
				current_user.unseen_notifications_count.to_s.html_safe
			end if current_user.unseen_notifications_count > 0 
			innerHtml << content_tag(:span,"", class:"icon20 notification")
			innerHtml.join.html_safe
		end
		html << render("user/notifications/resume_menu")
		html.join.html_safe
	end

	def link_to_notification(unread_count, &block)
		url = (unread_count >0) ? user_reset_unseen_notifications_count_path : "#"
		link_to(url, data:{remote:(unread_count >0),method: :put}, class:"notifications-icon", id:'notifications-menu-trigger',&block)
	end
end
