class CreateUserPoints < ActiveRecord::Migration
  def change
    create_table :user_points do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :number
      t.integer :origin, null:false
      t.integer :user_followed_id, index:true
      t.integer :user_follower_id, index:true
      t.integer :favorite_photo_id, index:true
      t.integer :user_favoriter_id, index:true
      t.timestamps null: false
    end
    add_foreign_key :user_points, :users, column: 'user_followed_id', name: 'user_points_user_followed'
    add_foreign_key :user_points, :users, column: 'user_follower_id', name: 'user_points_user_follower'
    add_foreign_key :user_points, :photos, column: 'favorite_photo_id', name: 'user_points_favorite_photo'
    add_foreign_key :user_points, :users, column: 'user_favoriter_id', name: 'user_points_user_favoriter'
  end
end
