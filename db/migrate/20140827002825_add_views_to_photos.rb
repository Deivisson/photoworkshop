class AddViewsToPhotos < ActiveRecord::Migration
  def change
  	add_column :photos, :views, :integer, null:false, default:0
  end
end
