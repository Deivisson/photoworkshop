class Portfolio < ActiveRecord::Base
	validates :i18n_key, presence:true, length: {maximum:150}
	validates :settings, presence:true

	def description
		I18n.t(self.i18n_key)
	end
end
