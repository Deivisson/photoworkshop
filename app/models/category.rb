class Category < ActiveRecord::Base
	DEFAULT_CATEGORY_ID = 1
	validates :description, presence:true, length: {maximum:40}, uniqueness:true
	has_many :user_profiles
	has_many :photos
	has_and_belongs_to_many :users
end
