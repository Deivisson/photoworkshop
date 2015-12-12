class WorkshopMaterial < ActiveRecord::Base
	
	validates :workshop_id, presence:true
	validates :attachment, presence:true
	validates :description, presence:true, length: {maximum:100}

  belongs_to :workshop

  has_attached_file :attachment,
                   :path => ":rails_root/public/workshop_material/:class/:attachment/:id/:style/:basename.:extension",
                   :url => "/workshop_material/:class/:attachment/:id/:style/:basename.:extension"

  validates_attachment_size :attachment, less_than: 10.1.megabytes, message: I18n.t("activerecord.errors.messages.file_size",size:10)
  validates_attachment_content_type :attachment, 
                              :content_type =>['application/zip','application/pdf', 'application/msword', 
                                'application/vnd.ms-office', 'application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                                'text/plain', /\Aimage\/.*\Z/]

  before_create :check_if_not_in_limit_of_workshop_plan


private
  
  def check_if_not_in_limit_of_workshop_plan
    unless self.workshop.can_add_material?
      errors[:base] << I18n.t('activerecord.errors.messages.limit_materials_plan_end')
      return false
    end
  end
end
