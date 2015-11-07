class FavoritePhoto < ActiveRecord::Base
	validates :photo_id, presence:true, uniqueness: {scope: :user_id}
	validates :user_id, presence:true

  belongs_to :photo
  belongs_to :user

	after_create :save_user_points, :save_points_for_user_photo_owner

private

	#Save the points for user that favorited the photo
  def save_user_points
    UserPoint.save_points(self.user_id, UserPoint::ADD_FAVORITE_PHOTO)
  end

  #Save the points for owner of photo
  def save_points_for_user_photo_owner
    UserPoint.save_points(self.photo.user_id, UserPoint::RECEIVE_FAVORITE_PHOTO)
  end

end
