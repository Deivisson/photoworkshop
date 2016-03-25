class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true, null:false
      t.string :integration_code
      t.integer :type_of, null:false
      t.references :productable, index: true, polymorphic: true
      t.integer :status, null:false
      t.timestamps null: false
    end
  end
end
