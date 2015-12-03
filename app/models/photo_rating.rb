class PhotoRating < ActiveRecord::Base
  belongs_to :photo
  belongs_to :criterium, class_name:"RatingCriterium", 
  												foreign_key: "rating_criterium_id"

  belongs_to :user #User evaluating the photo

  def score_perc
		self.score * 20
  end

end
