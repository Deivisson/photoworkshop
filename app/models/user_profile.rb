require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
class UserProfile < ActiveRecord::Base

  validates :user_name, presence:true, uniqueness:true
  validates :full_name, presence:true, length: {maximum:100}
  validate :verify_urls
  
  has_attached_file :avatar, 
                    :styles => { :medium => "500x500>", :thumb => "200x200>" }, 
                    :default_url => "user/no_avatar.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :avatar, less_than: 2.1.megabytes, message: I18n.t("activerecord.errors.messages.image_size",size:2)

  belongs_to :user
  belongs_to :category
  belongs_to :city

  attr_accessor :country_id, :state_id, :avatar_remote_url, :provider_shared

  before_validation :format_user_name
  after_save :save_user_points_if_add_cover_photo
  before_create :set_initial_datas
  
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

  def cover_url(size=:medium)
    photo_url = ""
    unless cover_photo_id.nil?
      photo = Photo.find(cover_photo_id)
      photo_url = photo.picture.url(size) unless photo.nil?
    end
    return photo_url
  end

  def short_name
    self.full_name.truncate(18)
  end

  def update_social_network_shared!(provider)
    method_name = "#{provider}_shared"
    if self.respond_to?(method_name) && !self.send("#{method_name}?")
      self.limit_upload_photo_by_day += 1
      self.send("#{method_name}=",true)
      if self.save
        User::NotificationMailer.upload_increased_message(self.user,provider).deliver
      end
    end 
  end

  def self.get_user_name(full_name)
    UserProfile.consist_user_name!(full_name)
  end

  def self.valid_user_name?(user_name)
    return (user_name == UserProfile.consist_user_name!(user_name))
  end

private 
  
  def set_initial_datas
    self.category_id = Category::DEFAULT_CATEGORY_ID
    self.limit_upload_photo_by_day = 1
    if self.avatar_remote_url.present?
      self.avatar = URI.parse(self.avatar_remote_url)
    end
  end 

  def save_user_points_if_add_cover_photo
    if self.cover_photo_id_changed? && self.cover_photo_id_was == nil
      UserPoint.save_points(self.user_id, UserPoint::ADD_COVER, {photo_id:self.cover_photo_id})
    end
  end

  def verify_urls
    valid_url!(:facebook,self.facebook)
    valid_url!(:twitter,self.twitter)
    valid_url!(:google_plus,self.google_plus)
    valid_url!(:tumblr,self.tumblr)
    valid_url!(:flickr,self.flickr)
  end

  def valid_url!(field,url)
    return unless url.present?
    self.send("#{field.to_s}=","http://#{url}") unless self.send("#{field.to_s}").include?("http")
    uri = URI.parse(url)
    uri.kind_of?(URI::HTTP)
  rescue URI::InvalidURIError
    self.errors.add(field, I18n.t('activerecord.errors.messages.invalid_url'))
    false
  end

  def format_user_name
    _name = user_name.blank? ? self.full_name.dup : self.user_name
    self.user_name = UserProfile.consist_user_name!(_name)
  end

  def self.consist_user_name!(name)
    name = name.gsub(' ','')
    name = name.gsub(/(á|à|ã|â|ä)/, 'a').gsub(/(é|è|ê|ë)/, 'e').gsub(/(í|ì|î|ï)/, 'i').gsub(/(ó|ò|õ|ô|ö)/, 'o').gsub(/(ú|ù|û|ü)/, 'u')
    name = name.gsub(/(Á|À|Ã|Â|Ä)/, 'A').gsub(/(É|È|Ê|Ë)/, 'E').gsub(/(Í|Ì|Î|Ï)/, 'I').gsub(/(Ó|Ò|Õ|Ô|Ö)/, 'O').gsub(/(Ú|Ù|Û|Ü)/, 'U')
    name = name.gsub(/ñ/, 'n').gsub(/Ñ/, 'N')
    name = name.gsub(/ç/, 'c').gsub(/Ç/, 'C')
    return name.downcase    
  end

end
