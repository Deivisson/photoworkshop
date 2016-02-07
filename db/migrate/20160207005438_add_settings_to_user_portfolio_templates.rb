class AddSettingsToUserPortfolioTemplates < ActiveRecord::Migration
  def change
    add_column :user_portfolio_templates, :settings, :string
  end
end
