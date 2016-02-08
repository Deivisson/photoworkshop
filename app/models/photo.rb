class Photo < ActiveRecord::Base
	
	validates :user_id, presence:true
	validates :picture, presence:true
	validates :category_id, presence:true

  belongs_to :user
  belongs_to :category
  belongs_to :workshop_activity_response
  has_one :exif, class_name:'PhotoExif', dependent: :destroy

  #Likes associations
  has_many :likes, class_name:'PhotoLike', dependent: :destroy
  has_many :likers, through: :likes, dependent: :destroy
  has_many :comments, class_name:'PhotoComment',dependent: :destroy
  has_many :ratings, class_name: "PhotoRating", dependent: :destroy
  has_many :favorites, class_name: "FavoritePhoto", dependent: :destroy
  has_many :user_points,foreign_key: "photo_id", dependent: :nullify
  
  has_attached_file :picture,:styles => {
    small:"250x250", 
    medium:"900x900",
    large: "1200X1200",
    huge: "2000x2000"
  }, default_url:"/images/missing.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :picture, less_than: 7.1.megabytes, message: I18n.t("activerecord.errors.messages.photo_size")

  before_destroy :check_if_can_be_destroyed
  after_post_process :save_exif
  after_create :save_user_points
  after_update :save_user_points_after_set_photo_as_cover

  scope :landscapes, -> {joins(:exif).where('photo_exifs.imagewidth > photo_exifs.imageheight')}
  scope :portraits, -> {joins(:exif).where('photo_exifs.imagewidth < photo_exifs.imageheight')}

  def author
    self.user.profile.short_name  
  end

  def orientation
    self.exif.imagewidth > self.exif.imageheight ? "landscape" : "portrait"
  end

  def landscape?
    self.exif.imagewidth > self.exif.imageheight
  end

  def portrait?
    self.exif.imagewidth < self.exif.imageheight
  end

  def update_views!
    self.update_attribute(:views,self.views+1)
  end

  def increment_likes!
    self.update_attribute(:likes_count,self.likes_count+1)
  end

  def decrement_likes!
    self.update_attribute(:likes_count,self.likes_count-1) if self.likes_count > 0
  end

  def camera
    return "-" if self.exif.model.nil?    
    self.exif.model
  end

  def lens
    return "-" if self.exif.model.nil?    
    self.exif.lens
  end  

  def iso
    return "-" if self.exif.iso.nil?
    self.exif.iso
  end

  def aperture
    return "-" if self.exif.aperture.nil?
    "f/#{self.exif.aperture}"
  end

  def shutter_speed
    return "-" if self.exif.shutter_speed.nil?    
    self.exif.shutter_speed
  end

  def focal_lenght
    return "-" if self.exif.focal_lenght.nil?    
    self.exif.focal_lenght
  end  

  def cover!
    self.update_attributes!(cover:true,cover_at:Time.now)
  end

  def uncover!
    self.update_attributes!(cover:false,cover_at:nil)
  end

  def self.cover
    Photo.where(cover:true).order(cover_at: :desc).limit(1).first
  end

  def self.posted_today_by_user(user)
    Photo.where("user_id = ? and (created_at between ? and ?)",
           user.id,Time.now.beginning_of_day,Time.now.end_of_day)
  end

  def rated?
    self.ratings.count > 0
  end

private 

  def save_exif
    #file = [Rails.root,"/public",self.picture.url(:original,timestamp:false)].join
    file = picture.queued_for_write[:original].path
    exif = MiniExiftool.new file
    attributes = {
      maker:exif.make,
      model:exif.model,
      lens:exif.lenstype,
      orientation:exif.orientation,
      shutter_speed:exif.shutterspeed,
      aperture:exif.fnumber,
      iso:exif.iso,
      taken_at:exif.createdate,
      flash:exif.flash,
      focal_lenght:exif.focallength,
      colorsapce:exif.colorspace,
      exposuremode:exif.exposuremode,
      whitebalance:exif.whitebalance,
      imagewidth:exif.imagewidth,
      imageheight:exif.imageheight,
      latitude:parse_latlong(exif.gpslatitude),
      longitude:parse_latlong(exif.gpslongitude)
    }
    self.exif = PhotoExif.new(attributes)
  end

  def save_user_points
    UserPoint.save_points(self.user_id, UserPoint::UPLOAD_PHOTO, {photo_id:self.id})
  end

  def save_user_points_after_set_photo_as_cover
    if self.cover_changed? && self.cover?
      UserPoint.save_points(self.user_id, UserPoint::PHOTO_COVERED, {photo_id:self.id})
    end
  end

  def parse_latlong(latlong)
    return unless latlong
    match, degrees, minutes, seconds, rotation = /(\d+) deg (\d+)' (.*)" (\w)/.match(latlong).to_a
    calculate_latlong(degrees, minutes, seconds, rotation)
  end

  def calculate_latlong(degrees, minutes, seconds, rotation)
    calculated_latlong = degrees.to_f + minutes.to_f/60 + seconds.to_f/3600
    ['S', 'W'].include?(rotation) ? -calculated_latlong : calculated_latlong
  end

  def check_if_can_be_destroyed
    unless UserProfile.where("user_id = ? and cover_photo_id = ? ", self.user_id,self.id).first.nil?
      errors.add(:base,I18n.t("activerecord.errors.messages.photo_cover_can_detroyed"))
      return false
    end
    if self.workshop_activity_response.present?
      errors.add(:base,I18n.t("activerecord.errors.messages.photo_activity_response"))
      return false
    end
  end
 
end
