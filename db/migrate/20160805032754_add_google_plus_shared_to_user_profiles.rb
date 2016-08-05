class AddGooglePlusSharedToUserProfiles < ActiveRecord::Migration
  def change
    add_column :user_profiles, :google_plus_shared, :boolean, null:false, default:false
  end
end
