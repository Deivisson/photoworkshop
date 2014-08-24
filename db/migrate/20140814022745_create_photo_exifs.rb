class CreatePhotoExifs < ActiveRecord::Migration
  def change
    create_table :photo_exifs do |t|
      t.references :photo, index: true, :null => false
      t.string :maker, :limit => 100
      t.string :model, :limit => 100
      t.string :lens, :limit => 100
      t.string :orientation, :limit => 100
      t.string :shutter_speed, :limit => 100 
      t.string :aperture, :limit => 100
      t.string :iso, :limit => 10
      t.datetime :taken_at
      t.string :flash, :limit => 100
      t.string :focal_lenght, :limit => 20
      t.string :colorsapce, :limit => 20
      t.string :exposuremode, :limit => 20
      t.string :whitebalance, :limit => 20
      t.integer :imagewidth
      t.integer :imageheight
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
    add_foreign_key :photo_exifs, :photos, name: 'fk_photos_exifs'
  end
end

