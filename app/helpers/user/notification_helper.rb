module User::NotificationHelper
	def link_to_notification(unread_count, &block)
		url = (unread_count >0) ? set_all_as_read_user_notifications_path : "#"
		link_to(url,remote:(unread_count >0), class:"notifications-icon", id:'notifications-menu-trigger',&block)
	end
end
