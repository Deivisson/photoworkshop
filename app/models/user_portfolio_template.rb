class UserPortfolioTemplate < ActiveRecord::Base
	validates :portfolio_template_id, presence:true, uniqueness: {scope: :user_id}
	validates :user_id, presence:true

  belongs_to :user
  belongs_to :template,
  					 class_name: "PortfolioTemplate", 	
						 foreign_key: 'portfolio_template_id'
end
