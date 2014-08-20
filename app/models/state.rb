class State < ActiveRecord::Base
	
	validates :name, presence:true, length: {maximum:100}, uniqueness:true
	validates :short_name, presence:true, length: {minimun:2,maximum:2}, uniqueness:true
	validates :country_id, presence:true
	      
  belongs_to :country
end
