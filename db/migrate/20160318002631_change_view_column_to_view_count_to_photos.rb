class ChangeViewColumnToViewCountToPhotos < ActiveRecord::Migration
  def change
  	rename_column :photos, :views, :views_count
  end
end
