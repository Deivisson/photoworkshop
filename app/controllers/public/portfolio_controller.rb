class Public::PortfolioController < ApplicationController
	layout 'public/photographer_portfolio'
	def index
		@photographer = current_user
	end
end