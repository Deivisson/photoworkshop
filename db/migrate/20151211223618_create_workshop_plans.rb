class CreateWorkshopPlans < ActiveRecord::Migration
  def change
    create_table :workshop_plans do |t|
      t.string :i18n_key, limit: 100
      t.text :settings
      t.boolean :active, null:false, default:false
      t.decimal :value, null:false, default:0, precision: 5, scale: 2
      t.timestamps null: false
    end
  end
end
