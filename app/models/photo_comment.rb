class PhotoComment < ActiveRecord::Base
	validates :content, presence:true, length: { maximum: 1500 }
	validates :user_id, presence:true
	validates :photo_id, presence:true

  belongs_to :user
  belongs_to :photo
end
