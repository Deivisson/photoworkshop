class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :user, index: true, :null => false
      t.references :category, index: true, :null => false
      t.string :title, :limit => 40
      t.text :description
      t.string :tags, :limit => 100
      t.attachment :picture
      t.timestamps
    end
    add_foreign_key :photos, :users, name: 'fk_photos_users'
    add_foreign_key :photos, :categories, name: 'fk_photos_category'
  end
end


