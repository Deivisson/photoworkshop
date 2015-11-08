class UserPoint < ActiveRecord::Base

	#Origins
	UPLOAD_PHOTO 						= 1 ; UPLOAD_PHOTO_POINTS 						= 5 	#okok
	ADD_COVER 							= 2 ; ADD_COVER_POINTS 								= 5 	#okok
	ADD_FAVORITE_PHOTO 			= 3 ;	ADD_FAVORITE_PHOTO_POINTS 			= 1 	#okok
	RECEIVE_FAVORITE_PHOTO 	= 4 ;	RECEIVE_FAVORITE_PHOTO_POINTS 	= 2 	#okok
	PHOTO_COVERED 					= 5 ;	PHOTO_COVERED_POINTS 						= 10 	#okok 
	FOLLOW 									= 6 ; FOLLOW_POINTS 									= 1 	#okok
	BE_FOLLOWED 						= 7 ; BE_FOLLOWED_POINTS 							= 2 	#okok
	SIGN_UP									= 8 ; SIGN_UP_POINTS									= 5 	#okok

	validates :user_id, presence:true
	validates :origin, presence:true
  belongs_to :user

  after_create :update_user_points

  def self.save_points(user_id,origin,optional_attributes={})
  	attributes = {
  		user_id:user_id,
  		origin:origin,
  		number:get_points(origin)
  	}.merge!(optional_attributes)
  	user_point = UserPoint.new(attributes)
    user_point.save! if check_if_can_save_user_points(user_point)
  end

private
	
	def update_user_points
		self.user.current_points += self.number
		self.user.save
	end
	
	def self.get_points(origin)
		case origin
		when UserPoint::UPLOAD_PHOTO
			return UserPoint::UPLOAD_PHOTO_POINTS
		when UserPoint::ADD_COVER
			return UserPoint::ADD_COVER_POINTS
		when UserPoint::ADD_FAVORITE_PHOTO 			
			return UserPoint::ADD_FAVORITE_PHOTO_POINTS
		when UserPoint::RECEIVE_FAVORITE_PHOTO 	
			return UserPoint::RECEIVE_FAVORITE_PHOTO_POINTS 
		when UserPoint::PHOTO_COVERED 					
			return UserPoint::PHOTO_COVERED_POINTS 
		when UserPoint::FOLLOW 									
			return UserPoint::FOLLOW_POINTS 
		when UserPoint::BE_FOLLOWED 						
			return UserPoint::BE_FOLLOWED_POINTS 
		when UserPoint::SIGN_UP									
			return UserPoint::SIGN_UP_POINTS 
		end
	end

	def self.check_if_can_save_user_points(user_point)
		case user_point.origin
		when UserPoint::ADD_FAVORITE_PHOTO
			return UserPoint.where("user_id = ? and favorite_photo_id = ? ", user_point.user_id, user_point.favorite_photo_id).first.nil?
		when RECEIVE_FAVORITE_PHOTO
			return UserPoint.where("user_id = ? and favorite_photo_id = ? and user_favoriter_id = ?", user_point.user_id, user_point.favorite_photo_id,user_point.user_favoriter_id).first.nil?
		when FOLLOW
			return UserPoint.where("user_id = ? and user_followed_id = ? ", user_point.user_id, user_point.user_followed_id).first.nil?
		when BE_FOLLOWED
			return UserPoint.where("user_id = ? and user_follower_id = ? ", user_point.user_id, user_point.user_follower_id).first.nil?
		else
			return true
		end
	end
end
