class AddLikesCountToPhotos < ActiveRecord::Migration
  def change
  	add_column :photos, :likes_count, :integer, null:false, default:0
  end
end
