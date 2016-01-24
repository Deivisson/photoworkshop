class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
    	t.string :i18n_key, null:false, limit: 150
    	t.text :settings, null:false
    	t.boolean :free, null:false, default:false
    	t.decimal :price, null:false, default:0, precision: 5, scale: 2
    	t.boolean :active, null:false, default:true
      t.timestamps null: false
    end
  end
end
