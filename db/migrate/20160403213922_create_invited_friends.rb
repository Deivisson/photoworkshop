class CreateInvitedFriends < ActiveRecord::Migration
  def change
    create_table :invited_friends do |t|
      t.references :user, index: true, foreign_key: true, null:false
      t.string :email, null:false
      t.integer :friend_id
      t.timestamps null: false
    end
    add_foreign_key :invited_friends, :users, name:"fk_users_friends", column:'friend_id'
  end
end
