class CreatePhotoLikes < ActiveRecord::Migration
  def change
    create_table :photo_likes do |t|
      t.references :photo, index: true
      t.references :user, index: true
      t.timestamps
    end
    add_foreign_key :photo_likes, :photos, name:'photo_likes_photos'
    add_foreign_key :photo_likes, :users, name:'photo_likes_user'
  end
end
