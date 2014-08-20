class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :user, presence:true
  validates :category, presence:true

      # validates :title, presence:true
      # validates :tags, presence:true
      # validates :camera, presence:true
      # validates :lens, presence:true
      # validates :aperture, presence:true
      # validates :shutter_speed, presence:true
      # t.date :taken_at
      # validates :focal_lenght, presence:true
      # validates :iso, presence:true


  has_many :photos
  has_many :categories
end
