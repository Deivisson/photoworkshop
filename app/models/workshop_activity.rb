class WorkshopActivity < ActiveRecord::Base
	validates :workshop_id, presence:true
	validates :description, presence:true, length: {maximum:100}
	validates :status, presence:true

  belongs_to :workshop
  has_many :responses, class_name: "WorkshopActivityResponse"

  def user_responses(user_id)
  	self.responses.where(user_id:user_id)
  end
end
