class FavoritePhoto < ActiveRecord::Base
	validates :photo_id, presence:true, uniqueness: {scope: :user_id}
	validates :user_id, presence:true

  belongs_to :photo
  belongs_to :user
end
