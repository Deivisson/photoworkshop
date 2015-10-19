class User::NotificationsController < User::BaseController

  def index
    @notifications = current_user.notifications_received
    respond_with(@notifications,layout:false)
  end
 
  def set_all_as_read
    Notification.set_all_as_read(current_user)
  end
end
