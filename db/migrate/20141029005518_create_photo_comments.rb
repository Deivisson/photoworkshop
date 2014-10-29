class CreatePhotoComments < ActiveRecord::Migration
  def change
    create_table :photo_comments do |t|
      t.references :user, index: true, null:false
      t.references :photo, index: true, null:false
      t.text :content, null:false
      t.timestamps
    end
    add_foreign_key :photo_comments, :users, name:'photo_comments_user'
    add_foreign_key :photo_comments, :photos, name:"photo_comments_photo"
  end
end
