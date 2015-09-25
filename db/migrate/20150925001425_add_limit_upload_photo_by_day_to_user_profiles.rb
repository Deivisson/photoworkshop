class AddLimitUploadPhotoByDayToUserProfiles < ActiveRecord::Migration
  def change
  	add_column :user_profiles, :limit_upload_photo_by_day, :integer, null:false, default:0
  end
end
