class AddColumnsToUserProfiles < ActiveRecord::Migration
  def change
    add_column :user_profiles, :available_for_freelance, :boolean, null:false , default:false
    add_column :user_profiles, :available_for_employment, :boolean, null:false, default:false
  end
end
