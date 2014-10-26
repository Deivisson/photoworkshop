class WorkshopActivity < ActiveRecord::Base
	validates :workshop_id, presence:true
	validates :description, presence:true, length: {maximum:100}
	validates :status, presence:true

  belongs_to :workshop
end
