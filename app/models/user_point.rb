class UserPoint < ActiveRecord::Base

	#Origins
	UPLOAD_PHOTO 						= 1 ; UPLOAD_PHOTO_POINTS 						= 5 	#OK
	ADD_COVER 							= 2 ; ADD_COVER_POINTS 								= 5 	#OK
	ADD_FAVORITE_PHOTO 			= 3 ;	ADD_FAVORITE_PHOTO_POINTS 			= 1 	#
	RECEIVE_FAVORITE_PHOTO 	= 4 ;	RECEIVE_FAVORITE_PHOTO_POINTS 	= 2 	#
	PHOTO_COVERED 					= 5 ;	PHOTO_COVERED_POINTS 						= 10 	#OK
	FOLLOW 									= 6 ; FOLLOW_POINTS 									= 1 	#OK
	BE_FOLLOWED 						= 7 ; BE_FOLLOWED_POINTS 							= 2 	#OK
	SIGN_UP									= 8 ; SIGN_UP_POINTS									= 5 	#OK

	validates :user_id, presence:true
	validates :origin, presence:true
  belongs_to :user
  belongs_to :photo

  before_create :actual_level
  after_create :update_user_points, 
  						 :notify_if_change_level, 
  						 :notify_if_photo_covered

  def self.save_points(user_id,origin,optional_attributes={})
  	attributes = {
  		user_id:user_id,
  		origin:origin,
  		number:get_points(origin)
  	}.merge!(optional_attributes)
  	user_point = UserPoint.new(attributes)
    user_point.save! if can_save_user_points(user_point)
  end

private
	
	def actual_level
		@actual_level = self.user.level	
	end

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

	def self.can_save_user_points(user_point)
		case user_point.origin
		when UserPoint::ADD_FAVORITE_PHOTO
			up = UserPoint.where("user_id = ? and photo_id = ?", user_point.user_id, user_point.photo_id)
			up = up.where("origin = ?",UserPoint::ADD_FAVORITE_PHOTO)
			return up.first.nil?
		
		when UserPoint::RECEIVE_FAVORITE_PHOTO
			up = UserPoint.where("user_id = ? and photo_id = ?", user_point.user_id, user_point.photo_id)
			up = up.where("userx_id = ? and origin = ?",user_point.userx_id,UserPoint::RECEIVE_FAVORITE_PHOTO)
			return up.first.nil?
		
		when UserPoint::FOLLOW
			up = UserPoint.where("user_id = ? and userx_id = ?", user_point.user_id, user_point.userx_id)
			up = up.where("origin = ?",UserPoint::FOLLOW)
			return up.first.nil?

		when UserPoint::BE_FOLLOWED
			up = UserPoint.where("user_id = ? and userx_id = ?", user_point.user_id, user_point.userx_id)
			up = up.where("origin = ?",UserPoint::BE_FOLLOWED)
			return up.first.nil?
		else
			return true
		end
	end

	def notify_if_change_level
   	new_level = User.find(self.user_id).level
   	if @actual_level.id != new_level.id
			attributes = {
	      content: I18n.t('notifications.user_change_level',old_level:@actual_level.description,new_level:new_level.description),
	      type_of: Notification::TYPE_CHANGE_LEVEL,
	      user_sender_id: User::SYSTEM_USER,
	      user_receiver_id: self.user_id,
	      read:false
	    }
	    Notification.create!(attributes)
	    User::NotificationMailer.change_level_message(self.user).deliver_now!
		end
	end

	def notify_if_photo_covered
		return unless self.origin == UserPoint::PHOTO_COVERED
		attributes = {
      content: I18n.t("notifications.photo_covered",points:self.number,photo:photo_link),
      type_of: Notification::TYPE_PHOTO_COVERED,
      user_sender_id: User::SYSTEM_USER,
      user_receiver_id: self.user_id,
      read:false
    }
    Notification.create!(attributes)
    User::NotificationMailer.photo_covered_message(self).deliver_now!
	end

	def photo_link
    img = ActionController::Base.helpers.image_tag(self.photo.picture.url(:small))
    photo_url = Rails.application.routes.url_helpers.user_photo_explore_show_path(self.photo_id)
    link = "<a href='#{photo_url}' src='#{self.photo.picture.url(:small)}' class='photo-picture aux-pic'>#{img.html_safe}</a>"
    link.html_safe
  end
end
