class WorkshopMaterial < ActiveRecord::Base
	
	validates :workshop_id, presence:true
	validates :attachment, presence:true
	validates :description, presence:true, length: {maximum:100}

  belongs_to :workshop

  has_attached_file :attachment,
                   :path => ":rails_root/public/workshop_material/:class/:attachment/:id/:style/:basename.:extension",
                   :url => "/workshop_material/:class/:attachment/:id/:style/:basename.:extension"

  validates_attachment_content_type :attachment, 
                              :content_type =>['application/pdf', 'application/msword', 'text/plain', /\Aimage\/.*\Z/]

end
