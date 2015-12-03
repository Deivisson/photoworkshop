class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter]

  SYSTEM_USER = 1

  #user's photos
  has_many :photos
  has_one :profile, class_name:'UserProfile'

  #Likes associations. Photos liked by user
  has_many :photo_likes
  has_many :liked_photos, class_name:'Photo',through: :photo_likes

  #define following and followers users
  has_many :user_relations, class_name:'UserRelation'

  #Workshops given by user
  has_many :owner_workshops, class_name:"Workshop"

  #Workshops that the user is a participant
  has_many :workshop_participants
  has_many :my_workshops, through: :workshop_participants
  has_many :photo_comments
  has_many :auths, class_name:"UserAuth"
  has_many :activity_responses, class_name: "WorkshopActivityResponse"
  has_many :notifications_sent, class_name: "Notification", foreign_key: 'user_sender_id'
  has_many :notifications_received, class_name: "Notification", foreign_key: 'user_receiver_id'
  has_many :favorite_photos
  has_many :points, class_name: "UserPoint"
  has_many :photo_ratings
  
  has_and_belongs_to_many :categories

  before_create :set_default_data
  after_create :create_profile, :send_welcome_notification, :save_user_points
  after_save :create_user_auth

  attr_accessor :following, :full_name, :user_name, :unread_notifications_count, :favorited_photos_ids, :level
  attr_accessor :auth_avatar_url, :auth_provider, :auth_uid, :account_url
  

  def following
    if @following.nil?
      @following = User.joins("INNER JOIN user_relations ON users.id = user_relations.user_followed_id")
      @following = @following.where("user_relations.user_id = ?",self.id)
    end
    @following
  end
  
  def following_count
    @following_count =  @following_count || following.size
  end

  def following_ids
    self.following.collect{|u| u.id}
  end

  def followers
    User.joins(:user_relations).where("user_relations.user_followed_id = ?",self.id) 
  end

  def followers_count
    @followers_count = @followers_count || followers.size
  end

  def photos_count
    @photos_count = @photos_count || photos.count
  end

  def owner_workshops_count
    @owner_workshops_count = @owner_workshops_count || self.owner_workshops.count
  end

  def self.from_omniauth(auth)
    user_auth = UserAuth.where(provider: auth[:provider], uid: auth[:uid]).first
    if user_auth.nil?
      user = User.where(email: auth[:email]).first || User.new
      if user.new_record?
        user.password         = Devise.friendly_token[0,20]
        user.full_name        = auth[:full_name]
        user.user_name        = auth[:user_name]
        user.auth_avatar_url  = auth[:avatar_url]
      end
      user.auth_provider    = auth[:provider]
      user.auth_uid         = auth[:uid]
      user.email            = auth[:email]
      user.account_url      = auth[:account_url]
      user.save if user.email.present?
    else
      user = user_auth.user
    end
    return user
  end

  def matricula_confirmed_for?(workshop)
    participant = workshop.workshop_participants.where(user_id:self.id).first
    return false if participant.nil?
    participant.confirmed?
  end

  def can_upload_photo_today?
    self.profile.limit_upload_photo_by_day > Photo.posted_today_by_user(self).count
  end

  def suggest_to_follow
    user_ids = self.following_ids
    user_ids.push(self.id)
    User.where("id not in (?)", user_ids).limit(2)
  end

  def last_received_notifications
    self.notifications_received.recents
  end

  def unread_notifications_count
    @unread_notifications_count ||= self.notifications_received.unread.count
  end

  def favorited_photos_ids
    @favorited_photos_ids ||= self.favorite_photos.collect{|p| p.photo_id}
  end

  def level
    @level ||= Level.by_user(self)
  end
private

	def set_default_data
    self.first_login = true  
  end

	def create_profile
 		self.profile = UserProfile.new(
      { user_name: user_name,
        full_name: full_name, 
        avatar_remote_url: auth_avatar_url
      })
	end

  def save_user_points
    UserPoint.save_points(self.id, UserPoint::SIGN_UP)
  end

  def send_welcome_notification
    attributes = {
      content: I18n.t('notifications.team_welcome'),
      type_of: Notification::TYPE_WELCOME,
      user_sender_id: SYSTEM_USER,
      user_receiver_id: self.id,
      read:false
    }
    Notification.create!(attributes)
  end

  def create_user_auth
    if (auth_provider.present? && auth_uid.present?)
      user_auth = UserAuth.where({user_id: id,provider: auth_provider,uid: auth_uid}).first
      if user_auth.nil?
        user_auth = UserAuth.new({user_id: id,provider: auth_provider,uid: auth_uid,account_url: account_url})
        user_auth.save
      end
    end
  end
end
