class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_sender_id, index: true
    	t.integer :user_receiver_id, index: true
      t.text :content
      t.boolean :read, null: false, default: false
      t.integer :type_of, null: false
      t.timestamps null: false
    end
    add_foreign_key :notifications, :users, column: 'user_sender_id', name: 'notifications_sender_user'
    add_foreign_key :notifications, :users, column: 'user_receiver_id', name: 'notifications_receiver_user'
  end
end
