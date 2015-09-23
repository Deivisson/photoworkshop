class AddCoverToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :cover, :boolean, null:false, default:false
    add_column :photos, :cover_at, :datetime
  end
end
