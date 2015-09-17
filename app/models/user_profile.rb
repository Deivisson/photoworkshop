require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
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

  attr_accessor :country_id, :state_id, :avatar_remote_url

  before_create :avatar_from_remote_url, :set_init_category

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

  def cover_url
    photo_url = ""
    unless cover_photo_id.nil?
      photo = Photo.find(cover_photo_id)
      photo_url = photo.picture.url(:medium) unless photo.nil?
    end
    return photo_url
  end

private 
  def avatar_from_remote_url
    if self.avatar_remote_url.present? && self.avatar.nil?
      self.avatar = URI.parse(self.avatar_remote_url)
    end
  end
  
  def set_init_category
    self.category_id = Category::DEFAULT_CATEGORY_ID
  end 
end
