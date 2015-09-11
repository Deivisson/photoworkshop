class WorkshopActivityResponse < ActiveRecord::Base
	validates :user_id, presence:true
	validates :workshop_activity_id, presence:true

  belongs_to :user
  belongs_to :workshop_activity
  has_many :photos

  #attr_accessor :photo
  accepts_nested_attributes_for :photos
end
