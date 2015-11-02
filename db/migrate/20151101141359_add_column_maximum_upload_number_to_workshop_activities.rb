class AddColumnMaximumUploadNumberToWorkshopActivities < ActiveRecord::Migration
  def change
  	add_column :workshop_activities, :maximum_upload_number, :integer, null:false, default:0
  end
end
