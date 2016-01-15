class PhotoComment < ActiveRecord::Base
	validates :content, presence:true, length: { maximum: 1500 }
	validates :user_id, presence:true
	validates :photo_id, presence:true

  belongs_to :user
  belongs_to :photo
  scope :from_workshop_activity, -> {where(from_workshop_activity:true)}

  after_create :notify_photo_owner 

private 

	# not register notification if the user that commented is the 
	# same photo's owner	
	def notify_photo_owner
		return if self.user_id == self.photo.user_id
		attributes = {
      content: I18n.t("notifications.photo_comment",user:user_link,comment_content:self.content,photo:get_photo),
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
