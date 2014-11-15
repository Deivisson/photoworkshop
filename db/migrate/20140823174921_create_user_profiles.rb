class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.references :user, index: true
      t.references :category, index: true
      t.text :description
      t.string :work, :limit => 50
      t.string :camera, :limit => 30
      t.string :home_page, :limit => 255
      t.string :facebook, :limit => 50
      t.string :twitter, :limit => 50
      t.string :google_plus, :limit => 50
      t.string :tumblr, :limit => 50
      t.string :flickr, :limit => 50
      t.timestamps
    end
    add_foreign_key :user_profiles, :users, name:'user_profiles_users'
    add_foreign_key :user_profiles, :categories, name:'user_profiles_categories'
  end
end
