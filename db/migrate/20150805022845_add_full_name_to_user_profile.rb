class AddFullNameToUserProfile < ActiveRecord::Migration
  def change
    add_column :user_profiles, :full_name, :string, limit: 100
  end
end
