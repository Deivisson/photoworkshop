class WorkshopParticipant < ActiveRecord::Base
	validates :user_id, presence:true, uniqueness: {scope: :workshop_id}
	validates :workshop_id, presence:true
	
  belongs_to :workshop 
  belongs_to :participant, class_name: "User", foreign_key: "user_id"
  belongs_to :participants_enrolled, class_name: "User", foreign_key: "user_id"
  belongs_to :user
  belongs_to :my_workshops, class_name: "Workshop", foreign_key: "workshop_id"

  before_create :check_if_has_available_vacancies, :set_in_queue
  before_save :remove_from_queue_wait
  after_create :notificate
  after_save :notificate, :if => Proc.new {|a| confirmed_changed? && confirmed? && !confirmed_was} 

  scope :confirmed, -> {where(confirmed:true)}

private
	
	def notificate
    i18n_key      = "notifications.#{(self.confirmed? ? "workshop_metriculated" : ".workshop_subscribe")}"
    workshop_path = Rails.application.routes.url_helpers.user_workshop_marketing_path(workshop_id:self.workshop_id)
    workshop_url  = "<a href='#{workshop_path}'>#{self.workshop.description}</a>"
    attributes = {
      content: I18n.t(i18n_key,workshop_url:workshop_url),
      type_of: Notification::TYPE_WORKSHOP_ADD_PARTICIPANT,
      user_sender_id: self.workshop.user_id,
      user_receiver_id: self.user.id,
      read:false
    }
    Notification.create!(attributes)

    #send emails
		if self.confirmed?
			User::WorkshopMailer.matriculated_message(self.workshop,self.user).deliver  	
		else	
      User::WorkshopMailer.subscribe_message(self.workshop,self.user).deliver
		end
  end

  def check_if_has_available_vacancies
  	if !self.workshop.has_vacancies? && !self.workshop.allow_queued?
  		errors[:base] << I18n.t("user.workshops.no_more_vacancies") 
  		return false
		end
  end

  def set_in_queue
    self.in_queue = true if self.workshop.in_queued_wait?
  end

  def remove_from_queue_wait
    self.in_queue = false if self.in_queue? && self.confirmed?
    return true
  end
end
