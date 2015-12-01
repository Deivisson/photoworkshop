class RatingCriterium < ActiveRecord::Base

	def description
		I18n.t(self.i18n_key)
	end
end
