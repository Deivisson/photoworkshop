class AddAvatarAndUserNameToUserProfiles < ActiveRecord::Migration
  def change
  	add_column :user_profiles, :user_name, :string, limit:50
		add_attachment :user_profiles, :avatar
  end
end
