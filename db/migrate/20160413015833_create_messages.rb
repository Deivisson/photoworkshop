class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.integer :user_sender_id, index: true
    	t.integer :user_receiver_id, index: true
      t.text :content
      t.boolean :read, null: false, default: false
      t.timestamps null: false
    end
    add_foreign_key :messages, :users, column: 'user_sender_id', name: 'messages_sender_user'
    add_foreign_key :messages, :users, column: 'user_receiver_id', name: 'messages_receiver_user'
  end
end
