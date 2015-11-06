class CreateUserPoints < ActiveRecord::Migration
  def change
    create_table :user_points do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :number
      t.integer :origin, null:false
      t.timestamps null: false
    end
  end
end
