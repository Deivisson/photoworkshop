class PortfolioTemplate < ActiveRecord::Base
	
	validates :i18n_key, presence:true, length: {maximum:150}
	validates :settings, presence:true
	has_many :user_portfolio_templates

	def description
		I18n.t(self.i18n_key)
	end
end
