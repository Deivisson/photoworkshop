class City < ActiveRecord::Base
  belongs_to :state
  has_many :user_profiles
end
