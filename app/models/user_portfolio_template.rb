class UserPortfolioTemplate < ActiveRecord::Base
  belongs_to :user
  belongs_to :template, class_name: "PortfolioTemplate"
end
