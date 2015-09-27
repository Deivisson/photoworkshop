class AddSocialNetWorkSharedColumnsToUserProfiles < ActiveRecord::Migration
  def change
    add_column :user_profiles, :facebook_shared, :boolean, null:false, default:false
    add_column :user_profiles, :twitter_shared, :boolean, null:false, default:false
  end
end
