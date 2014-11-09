class PhotoLike < ActiveRecord::Base
	belongs_to :user
	belongs_to :photo
  belongs_to :liked_photos, class_name:"Photo", foreign_key: "photo_id"
  belongs_to :liker, class_name:"User", foreign_key: "user_id"

  after_create do 
  	self.photo.increment_likes!
  end

  after_destroy do 
  	self.photo.decrement_likes!
  end
end
