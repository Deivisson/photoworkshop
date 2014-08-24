class PhotoExif < ActiveRecord::Base
	validates :photo_id, presence:true
  belongs_to :photo
end
