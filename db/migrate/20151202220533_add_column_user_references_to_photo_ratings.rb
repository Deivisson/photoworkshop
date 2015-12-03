class AddColumnUserReferencesToPhotoRatings < ActiveRecord::Migration
  def change
    add_reference :photo_ratings, :user, index: true, foreign_key: true
  end
end
