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

  after_create :create_profile

private
	
	def create_profile
  		self.profile = UserProfile.new
	end  	
end
