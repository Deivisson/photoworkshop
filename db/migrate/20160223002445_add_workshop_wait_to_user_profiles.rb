class AddWorkshopWaitToUserProfiles < ActiveRecord::Migration
  def change
  	add_column :user_profiles, :workshop_wait, :boolean, null:false, default:false
  end
end
