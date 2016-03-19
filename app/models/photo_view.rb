class PhotoView < ActiveRecord::Base
	SEARCH_BY_IP      = 1
	SEARCH_BY_ADDRESS = 2
	
	validates :photo_id, presence:true
	validates :search_method, presence:true

	belongs_to :photo
	belongs_to :user
end
