class FavoritePhoto < ActiveRecord::Base
	validates :photo_id, presence:true, uniqueness: {scope: :user_id}
	validates :user_id, presence:true

  belongs_to :photo
  belongs_to :user

	after_create :save_user_points, :save_points_for_user_photo_owner

private

	#Save the points for user that favorited the photo
  def save_user_points
    attributes = {
    	user_id:self.user_id,
    	origin:UserPoint::ADD_FAVORITE_PHOTO, 
    	number:UserPoint::ADD_FAVORITE_PHOTO_POINTS}
    UserPoint.create!(attributes)
  end

  #Save the points for owner of photo
  def save_points_for_user_photo_owner
    attributes = {
    	user_id:self.photo.user_id,
    	origin:UserPoint::RECEIVE_FAVORITE_PHOTO, 
    	number:UserPoint::RECEIVE_FAVORITE_PHOTO_POINTS}
    UserPoint.create!(attributes)
  end

end
