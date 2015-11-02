class WorkshopActivityResponse < ActiveRecord::Base
	validates :user_id, presence:true
	validates :workshop_activity_id, presence:true

  belongs_to :user
  belongs_to :workshop_activity
  has_one :photo, dependent: :destroy

  attr_accessor :can_upload
  accepts_nested_attributes_for :photo

  before_save :check_if_can_upload

  def can_upload?
  	return @can_upload unless @can_upload.nil?
  	activity = self.workshop_activity
  	response_count = WorkshopActivityResponse.where("workshop_activity_id = ? and user_id = ?",activity.id,self.user_id).count
		return (response_count < workshop_activity.maximum_upload_number && !activity.time_over? )
  end

private
	
	def check_if_can_upload
		unless can_upload?
			errors.add(:base, I18n.t('user.workshop_responses.upload_not_allowed_by_limit')) 
		end
  end  
end
