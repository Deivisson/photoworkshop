class CreateUserAuths < ActiveRecord::Migration
  def change
    create_table :user_auths do |t|
    	t.references :user, index: true, null:false
      t.string :provider, null:false
      t.string :uid, null:false
      t.timestamps
    end
    add_foreign_key :user_auths, :users, name:'user_auths_users'
  end
end
