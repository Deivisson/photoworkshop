class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter]

  #user's photos
  has_many :photos
  has_many :categories
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

  after_create :create_profile
  after_save :create_user_auth

  attr_accessor :following, :full_name, :user_name, :auth_avatar_url, :auth_provider, :auth_uid
  

  def cover_photo
    cover = self.photos.landscapes.limit(1).first
    if cover.nil?
      "mini_cover.png"
    else
      cover.picture.url(:medium)
    end
  end

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
      user.save if user.email.present?
    else
      user = user_auth.user
    end
    return user
  end


private
	
	def create_profile
  		self.profile = UserProfile.new(
        { user_name: user_name,full_name: full_name, avatar_remote_url: auth_avatar_url})
	end

  def create_user_auth
    if (auth_provider.present? && auth_uid.present?)
      UserAuth.where({user_id: id ,provider: auth_provider, uid:auth_uid}).first_or_create
    end
  end
end
