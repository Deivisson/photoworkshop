class WorkshopParticipant < ActiveRecord::Base
	validates :user_id, presence:true, uniqueness: {scope: :workshop_id}
	validates :workshop_id, presence:true
	
  belongs_to :participant, class_name: "User", foreign_key: "user_id"
  belongs_to :my_workshops, class_name: "Workshop", foreign_key: "workshop_id"
end
