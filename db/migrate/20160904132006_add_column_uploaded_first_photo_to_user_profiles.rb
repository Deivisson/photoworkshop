class AddColumnUploadedFirstPhotoToUserProfiles < ActiveRecord::Migration
  def change
    add_column :user_profiles, :uploaded_first_photo, :boolean, null:false,default:false
  end
end
