class CreatePhotoExifs < ActiveRecord::Migration
  def change
    create_table :photo_exifs do |t|
      t.references :photo, index: true, :null => false
      t.string :maker, :limit => 60
      t.string :model, :limit => 50
      t.string :lens, :limit => 30
      t.string :orientation, :limit => 40
      t.string :shutter_speed, :limit => 10 
      t.string :aperture, :limit => 10
      t.string :iso, :limit => 6
      t.datetime :taken_at
      t.string :flash, :limit => 30
      t.string :focal_lenght, :limit => 20
      t.string :colorsapce, :limit => 20
      t.string :exposuremode, :limit => 20
      t.string :whitebalance, :limit => 20
      t.integer :imagewidth
      t.integer :imageheight
      t.timestamps
    end
    add_foreign_key :photo_exifs, :photos, name: 'fk_photos_exifs'
  end
end

