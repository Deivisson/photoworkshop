class AddWorkshopActivityResponseIdToPhotos < ActiveRecord::Migration
  def change
    add_reference :photos, :workshop_activity_response, index: true
  end
end
