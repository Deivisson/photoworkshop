class Notification < ActiveRecord::Base

	TYPE_WELCOME = 1
	TYPE_FOLLOWED = 2

  TYPE_WORKSHOP_ADD_PARTICIPANT = 3
  TYPE_WORKSHOP_ADD_ACTIVITY = 4
  TYPE_WORKSHOP_ACTIVITY_RESPONSE = 6
  
  TYPE_PHOTO_COMMENT = 10
  TYPE_PHOTO_COVERED = 11


  TYPE_CHANGE_LEVEL = 20

	validates :content, presence:true
	validates :type_of, presence:true
	validates :user_sender_id, presence:true
	validates :user_receiver_id, presence:true

  belongs_to :sender, class_name: "User", foreign_key: 'user_sender_id'
  belongs_to :receiver, class_name: "User", foreign_key: 'user_receiver_id'

  default_scope -> {order("created_at desc")}
  scope :recents, -> {limit(5)}
  scope :unread, -> {where(read:false)}

  def self.set_all_as_read(user_id)
  	Notification.where("read = ? and user_receiver_id = ? ",false,user_id).update_all(read:true)
  end
end
