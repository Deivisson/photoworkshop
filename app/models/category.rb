class Category < ActiveRecord::Base
	validates :description, presence:true, length: {maximum:40}, uniqueness:true
end
