class UserRelation < ActiveRecord::Base
	validates :user_id, presence:true
	validates :user_followed_id, presence:true, uniqueness: {scope: :user_id}

  belongs_to :user
  after_create :notificate_followed

  private 

  def notificate_followed
		link = "<a class='photographer-profile' href='/user/photographers/#{user_id}'>#{self.user.profile.user_name} </a> "
		attributes = {
      content: I18n.t("notifications.followed",follower: link),
      type_of: Notification::TYPE_FOLLOWED,
      user_sender_id: self.user_id,
      user_receiver_id: self.user_followed_id,
      read:false
    }
    Notification.create!(attributes)
  end

end
