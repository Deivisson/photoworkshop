class AddCoverPhotoIdToUserProfiles < ActiveRecord::Migration
  def change
  	add_column :user_profiles, :cover_photo_id, :integer
  	add_foreign_key :user_profiles, :photos, column: 'cover_photo_id', name:'user_profiles_photos'
  end
end
