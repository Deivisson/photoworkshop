class ChangeFavoritePhotoIdColumnNameToPhotoId < ActiveRecord::Migration
  def change
		rename_column  :user_points, :favorite_photo_id, :photo_id
  end
end
