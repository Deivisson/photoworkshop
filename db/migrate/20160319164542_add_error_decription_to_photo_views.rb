class AddErrorDecriptionToPhotoViews < ActiveRecord::Migration
  def change
  	add_column :photo_views, :error_description,:text
  end
end
