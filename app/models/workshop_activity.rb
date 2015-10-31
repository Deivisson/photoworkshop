class WorkshopActivity < ActiveRecord::Base
	validates :workshop_id, presence:true
	validates :description, presence:true, length: {maximum:100}
	validates :status, presence:true

  belongs_to :workshop
  has_many :responses, class_name: "WorkshopActivityResponse"

  def user_responses(user_id)
  	self.responses.where(user_id:user_id)
  end
	
	after_create :notificate_participants

private

  def notificate_participants
    path = Rails.application.routes.url_helpers.user_workshop_path(id:self.workshop_id)
    url  = "<a href='#{path}'>#{self.workshop.description}</a>"
		attributes = {
      content: I18n.t("notifications.workshop_added_activity",workshop_url:url),
      type_of: Notification::TYPE_WORKSHOP,
      user_sender_id: self.workshop.user_id,
      read:false
  	}
    self.workshop.participants.each do |participant|
	  	attributes.merge!(user_receiver_id:participant.id)  
      Notification.create!(attributes)
    end
  end  
end
