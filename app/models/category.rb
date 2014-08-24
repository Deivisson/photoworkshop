class Category < ActiveRecord::Base
	validates :description, presence:true, length: {maximum:40}, uniqueness:true
	has_many :user_profiles
	has_many :photos
end
