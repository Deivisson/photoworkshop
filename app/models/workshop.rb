class Workshop < ActiveRecord::Base

  PUBLISHED = 1
  
  validates :user, presence:true
  validates :description, presence:true, length: {maximum:200}
  validates :start_date, presence:true
  validates :end_date, presence:true
  validates :vacancies_number, presence:true, numericality: {only_integer:true}
  #validates :value, presence:true, numericality:true
  validates :status, presence:true
  validate :start_date_less_than_end_date

  has_attached_file :image, 
                    :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
                    :default_url => "user/no_image.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :image, less_than: 2.1.megabytes, message: I18n.t("activerecord.errors.messages.image_size",size:2)

  #is the owner of workshop
  belongs_to :user

  has_many :workshop_participants
  has_many :participants,-> { where("workshop_participants.confirmed" => true) }, through: :workshop_participants
  has_many :participants_enrolled,  through: :workshop_participants #include all 
  
  has_many :materials, class_name: "WorkshopMaterial"
  has_many :activities, class_name: "WorkshopActivity"

  before_save :uncheck_allow_queued_if_allow_pre_enrolls

  def published?
    self.status == PUBLISHED
  end

  def mine?(user)
    self.user_id == user.id
  end

  def enrolled?(user)
    self.participant_ids.include?(user.id)
  end

  def subscribe!(user)
    @workshop_participant = self.workshop_participants.build(user_id:user.id)
    @workshop_participant.confirmed = false
    @workshop_participant.save
    @workshop_participant
  end

  def has_vacancies?
    (self.vacancies_number - self.participants_enrolled.count) > 0
  end

  def in_queued_wait?
    !has_vacancies? && self.allow_queued?
  end

private 
  def start_date_less_than_end_date
    return if self.start_date.nil? || self.end_date.nil?
    if self.start_date > self.end_date
      self.errors[:start_date] << I18n.t("activerecord.errors.messages.start_date_less_than_end_date")
      return false
    end
  end

  def uncheck_allow_queued_if_allow_pre_enrolls
    self.allow_queued = false unless self.allow_pre_enrolls?
  end
end
