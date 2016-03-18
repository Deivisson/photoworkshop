class CreatePhotoViews < ActiveRecord::Migration
  def change
    create_table :photo_views do |t|
      t.references :photo, index: true, null:false, foreign_key: true
      t.references :user, index: true, null:false, foreign_key: true
      t.string :ip
      t.string :country_code, limit:5
      t.string :country_name
      t.string :region_code, limit:5
      t.string :region_name
      t.string :city
      t.string :zip_code
      t.float :latitude
      t.float :longitude
      t.timestamps null: false
    end
  end
end
