class AddColumnFromWorkshopActivityToPhotoCommentsTable < ActiveRecord::Migration
  def change
    add_column :photo_comments, :from_workshop_activity, :boolean, null:false, default:false
  end
end
