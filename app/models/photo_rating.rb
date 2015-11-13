class PhotoRating < ActiveRecord::Base
  belongs_to :photo
  belongs_to :rate_criterium
end
