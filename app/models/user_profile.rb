class UserProfile < ActiveRecord::Base

  validates :user_name, presence:true
  validates :full_name, presence:true, length: {maximum:100}, uniqueness:true
  
  has_attached_file :avatar, 
                    :styles => { :medium => "500x500>", :thumb => "100x100>" }, 
                    :default_url => "user/no_avatar.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  belongs_to :user
  belongs_to :category
  belongs_to :city
  attr_accessor :country_id, :state_id


  def state_id
  	if @state_id.nil? && !self.city_id.nil?
  		@state_id = self.city.state_id
  	end
  	@state_id
  end

  def country_id
  	if @country_id.nil? && !self.city_id.nil?
  		@country_id = self.city.state.country_id
  	end
  	@country_id
  end
end
