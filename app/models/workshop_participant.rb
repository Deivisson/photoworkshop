class WorkshopParticipant < ActiveRecord::Base
	validates :user_id, presence:true, uniqueness: {scope: :workshop_id}
	validates :workshop_id, presence:true
	
  belongs_to :workshop 
  belongs_to :participant, class_name: "User", foreign_key: "user_id"
  belongs_to :user
  belongs_to :my_workshops, class_name: "Workshop", foreign_key: "workshop_id"

  before_create :check_if_has_available_vacancies
  after_create :notificate
  after_save :notificate, :if => Proc.new {|a| confirmed_changed? && confirmed? && !confirmed_was} 

private
	
	def notificate
		if self.confirmed?
			User::WorkshopMailer.matriculated_message(self.workshop,self.user).deliver  	
		else	
			User::WorkshopMailer.subscribe_message(self.workshop,self.user).deliver  	
		end
  end

  def check_if_has_available_vacancies
  	unless self.workshop.has_vacancies?
  		errors[:base] << I18n.t("user.workshops.no_more_vacancies") 
  		return false
		end
  end
end
