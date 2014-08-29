class PhotoLike < ActiveRecord::Base
	belongs_to :user
	belongs_to :photo
  belongs_to :liked_photos, class_name:"Photo", foreign_key: "photo_id"
  belongs_to :admirer, class_name:"User", foreign_key: "user_id"
end
