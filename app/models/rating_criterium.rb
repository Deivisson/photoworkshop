class RatingCriterium < ActiveRecord::Base
	has_many :photo_ratings
	def description
		I18n.t(self.i18n_key)
	end
end
