class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


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

  after_create :create_profile

  attr_accessor :following

  def cover_photo
    self.photos.landscapes.limit(1).first
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

private
	
	def create_profile
  		self.profile = UserProfile.new(user_name:"DeivissonBruno")
	end  	
end
