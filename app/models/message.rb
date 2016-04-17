class Message < ActiveRecord::Base
	validates :content, presence:true
	validates :user_sender_id, presence:true
	validates :user_receiver_id, presence:true

	belongs_to :sender, class_name: "User", foreign_key: 'user_sender_id'
	belongs_to :receiver, class_name: "User", foreign_key: 'user_receiver_id'

	scope :lasts, -> {select("user_sender_id,max(id) as id,max(content) as content,max(created_at) as created_at").group("user_sender_id").order("created_at desc")}
	scope :recents, -> {limit(5).order("created_at desc")}

	after_create :increment_unseen_messages_count

	def self.lasts_messages(user)
		@messages = Message.where("id in (select max(id) as id from messages group by user_sender_id)")
		@messages = @messages.where("user_receiver_id = ?",user.id).order("created_at desc")
	end

	def self.all_by_user(user_id,sender_id)
		message = Message.where("(user_sender_id = ? and user_receiver_id = ?) or 
														 (user_sender_id = ? and user_receiver_id = ?) ",sender_id,user_id,user_id,sender_id)
		message = message.order("created_at asc")
		message
	end

private 
	def increment_unseen_messages_count
		self.receiver.unseen_messages_count += 1
    self.receiver.save
	end
end
