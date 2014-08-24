class AddCityColumnToUserProfiles < ActiveRecord::Migration
  def change
  	add_column :user_profiles, :city_id, :integer, index:true
    add_foreign_key :user_profiles, :cities, name:'user_profiles_cities'
  end
end
