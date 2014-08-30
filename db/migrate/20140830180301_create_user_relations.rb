class CreateUserRelations < ActiveRecord::Migration
  def change
    create_table :user_relations do |t|
      t.references :user, index: true
      t.integer :user_followed_id
      t.timestamps
    end
    add_foreign_key :user_relations, :users, name:'user_relations_users'
    add_foreign_key :user_relations, :users, name:'user_relations_users_followed', column:'user_followed_id'
  end
end
