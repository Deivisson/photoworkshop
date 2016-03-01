class PhotoRating < ActiveRecord::Base
	validates :score, numericality: { only_integer: true, less_than_or_equal_to:5 }
	validates :photo_id, presence:true
	
  belongs_to :photo
  belongs_to :criterium, class_name:"RatingCriterium", 
  												foreign_key: "rating_criterium_id"

  belongs_to :user #User evaluating the photo
  belongs_to :workshop_activity_response
  
  def score_perc
		self.score * 20
  end

end
