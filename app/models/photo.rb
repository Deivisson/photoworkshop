class Photo < ActiveRecord::Base
	
	validates :user_id, presence:true
	validates :picture, presence:true
	validates :category_id, presence:true

  belongs_to :user
  belongs_to :category
  has_one :exif
  
  has_attached_file :picture, :styles => {small:"300x300", medium:"800x800"}, default_url:"/images/missing.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
end
