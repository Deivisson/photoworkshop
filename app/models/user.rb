class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :photos
  has_many :categories
  has_one :profile, class_name:'UserProfile'

  after_create :create_profile

private
	
	def create_profile
  		self.profile = UserProfile.new
	end  	
end
