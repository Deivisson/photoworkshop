class AddWorkshopActivityResponseIdToPhotoRatings < ActiveRecord::Migration
  def change
    add_reference :photo_ratings, :workshop_activity_response, index: true, foreign_key: true
  end
end
