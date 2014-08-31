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

  after_create :create_profile

  attr_accessor :following

  def following
    if @following.nil?
      @following = User.joins("INNER JOIN user_relations ON users.id = user_relations.user_followed_id")
      @following = @following.where("user_relations.user_id = ?",self.id)
    end
    @following
  end
  
  def following_ids
    self.following.collect{|u| u.id}
  end

  def followers
    User.joins(:user_relations).where("user_relations.user_followed_id = ?",self.id) 
  end
private
	
	def create_profile
  		self.profile = UserProfile.new
	end  	
end
