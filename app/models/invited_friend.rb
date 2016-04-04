class InvitedFriend < ActiveRecord::Base
	validates :user_id, presence:true
	validates :email, presence:true 
	validates :email, uniqueness:{scope: :user_id,
						message: I18n.t("activerecord.errors.messages.invited_friend_already_sended")}, on: :create

  belongs_to :user

  before_validation :check_if_already_have_user_for_email,
  									:check_if_email_is_valid, on: :create

	after_create :send_invite

private 
	
	def check_if_already_have_user_for_email
		return if self.email.empty?
		unless User.where(email:self.email).first.nil?
			self.errors[:base] << I18n.t("activerecord.errors.messages.invited_friend_already_registered")
			return false
		end
		return true
	end

	def check_if_email_is_valid
		return if self.email.empty?
		unless self.email =~ /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]+\z/i
			self.errors[:base] << I18n.t("activerecord.errors.messages.invalid_email")
			return false
		end
		return true
	end

	def send_invite
		User::NotificationMailer.invited_friend_message(self).deliver_now!
	end

	# def notificate_user
	# 	attributes = {
 #      content: I18n.t('notifications.team_welcome'),
 #      type_of: Notification::TYPE_WELCOME,
 #      user_sender_id: SYSTEM_USER,
 #      user_receiver_id: self.user_id,
 #      read:false
 #    }
 #    Notification.create!(attributes)
	# end
end
