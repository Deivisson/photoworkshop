class UserPoint < ActiveRecord::Base

	#Origins
	UPLOAD_PHOTO 						= 1 ; UPLOAD_PHOTO_POINTS 						= 5 #ok
	ADD_COVER 							= 2 ; ADD_COVER_POINTS 								= 5
	ADD_FAVORITE_PHOTO 			= 3 ;	ADD_FAVORITE_PHOTO_POINTS 			= 1 #ok
	RECEIVE_FAVORITE_PHOTO 	= 4 ;	RECEIVE_FAVORITE_PHOTO_POINTS 	= 2 #ok
	PHOTO_COVERED 					= 5 ;	PHOTO_COVERED_POINTS 						= 10
	FOLLOW 									= 6 ; FOLLOW_POINTS 									= 1 #ok
	BE_FOLLOWED 						= 7 ; BE_FOLLOWED_POINTS 							= 2 #ok


	validates :user_id, presence:true
	validates :origin, presence:true
  belongs_to :user

  after_create :update_user_points

private
	
	def update_user_points
		self.user.current_points += self.number
		self.user.save
	end

end
