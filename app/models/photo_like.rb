class PhotoLike < ActiveRecord::Base
	belongs_to :user
	belongs_to :photo
  belongs_to :liked_photos, class_name:"Photo", foreign_key: "photo_id"
  belongs_to :liker, class_name:"User", foreign_key: "user_id"

  after_create do 
  	self.photo.increment_likes!
    notify_photo_owner
  end

  after_destroy do 
  	self.photo.decrement_likes!
  end


private 

  # not register notification if the user that liked is the 
  # same photo's owner  
  def notify_photo_owner
    return if self.user_id == self.photo.user_id
    attributes = {
      content: I18n.t("notifications.photo_like",user:user_link,photo:get_photo),
      type_of: Notification::TYPE_PHOTO_COMMENT,
      user_receiver_id: self.photo.user_id,
      user_sender_id: self.user_id,
      read:false
    }
    Notification.create!(attributes)
  end

  def user_link
    user_url = Rails.application.routes.url_helpers.user_photographer_path(self.user_id)
    link = "<a class='photographer-profile' href='#{user_url}'>#{self.user.profile.user_name} </a> "
    link.html_safe
  end

  def get_photo
    img = ActionController::Base.helpers.image_tag(self.photo.picture.url(:small))
    photo_url = Rails.application.routes.url_helpers.user_photo_explore_show_path(self.photo_id)
    link = "<a href='#{photo_url}' src='#{self.photo.picture.url(:small)}' class='photo-picture aux-pic'>#{img.html_safe}</a>"
    link.html_safe
  end


end
