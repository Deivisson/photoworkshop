class Workshop < ActiveRecord::Base

  OPENED = 1
  
  validates :user, presence:true
  validates :description, presence:true, length: {maximum:200}
  validates :start_date, presence:true
  validates :end_date, presence:true
  validates :vacancies_number, presence:true, numericality: {only_integer:true}
  validates :value, presence:true, numericality:true
  validates :status, presence:true

  has_attached_file :image, 
                    :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
                    :default_url => "user/no_avatar.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :user

  has_many :workshop_participants
  has_many :participants, through: :workshop_participants

  has_many :materials, class_name: "WorkshopMaterial"
  has_many :activities, class_name: "WorkshopActivity"

  def opened?
    self.status == OPENED
  end
end
