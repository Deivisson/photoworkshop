class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :user, index: true, :null => false
      t.references :category, index: true, :null => false
      t.string :title, :limit => 40
      t.text :description
      t.string :tags, :limit => 100
      t.string :camera, :limit => 50
      t.string :lens, :limit => 50
      t.string :aperture, :limit => 10
      t.string :shutter_speed, :limit => 10
      t.date :taken_at
      t.string :focal_lenght, :limit => 4
      t.string :iso, :limit => 6
      t.timestamps
    end
    add_foreign_key :photos, :users, name: 'fk_photos_users'
    add_foreign_key :photos, :categories, name: 'fk_photos_category'
  end
end
