class CreateUserPortfolios < ActiveRecord::Migration
  def change
    create_table :user_portfolios do |t|
      t.references :user, index: true, null:false, foreign_key: true
      t.references :portfolio, index: true, null:false, foreign_key: true
      t.boolean :active, null:false
      t.timestamps null: false
    end
  end
end
