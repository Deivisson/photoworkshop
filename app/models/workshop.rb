class Workshop < ActiveRecord::Base

  OPENED = 1
  
  validates :user, presence:true
  validates :description, presence:true, length: {maximum:200}
  #validates :start_date, presence:true
  #validates :end_date, presence:true
  validates :vacancies_number, presence:true, numericality: {only_integer:true}
  #validates :value, presence:true, numericality:true
  validates :status, presence:true

  has_attached_file :image, 
                    :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
                    :default_url => "user/no_avatar.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  #is the owner of workshop
  belongs_to :user

  has_many :workshop_participants
  has_many :participants,-> { where("workshop_participants.confirmed" => true) }, through: :workshop_participants


  has_many :materials, class_name: "WorkshopMaterial"
  has_many :activities, class_name: "WorkshopActivity"

  def opened?
    self.status == OPENED
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
  end

  def has_vacancies?
    (self.vacancies_number - self.participants.count) > 0
  end
end
