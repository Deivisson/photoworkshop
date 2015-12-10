class WorkshopActivityResponse < ActiveRecord::Base
	validates :user_id, presence:true
	validates :workshop_activity_id, presence:true

  belongs_to :user
  belongs_to :workshop_activity
  has_one :photo, dependent: :destroy
  has_many :photo_ratings

  attr_accessor :can_upload
  accepts_nested_attributes_for :photo

  before_save :check_if_can_upload
  before_destroy :check_if_can_destroy, prepend: true
  after_create :send_notification

  def can_upload?
  	return @can_upload unless @can_upload.nil?
  	activity = self.workshop_activity
  	response_count = WorkshopActivityResponse.where("workshop_activity_id = ? and user_id = ?",activity.id,self.user_id).count
		return (response_count < workshop_activity.maximum_upload_number && !activity.time_over? )
  end

private
	
	def check_if_can_upload
		unless can_upload?
			errors.add(:base, I18n.t('user.workshop_activity_responses.upload_not_allowed_by_limit')) 
		end
  end  

  def check_if_can_destroy
    unless self.photo_ratings.limit(1).first.nil?
      errors.add(:base, I18n.t('user.workshop_activity_responses.can_be_destroyed'))
      return false
    end
  end

  def send_notification
    attributes = {
      content: I18n.t('notifications.workshop_activity_response',participant:self.user.user_name),
      type_of: Notification::TYPE_WORKSHOP_ACTIVITY_RESPONSE,
      user_sender_id: self.user_id,
      user_receiver_id:self.workshop_activity.workshop.user_id ,
      read:false
    }
    Notification.create!(attributes)
  end
end
