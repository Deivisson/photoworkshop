class UnSeenColumnsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :unseen_notifications_count, :integer, null:false, default:0
  	add_column :users, :unseen_messages_count, :integer, null:false, default:0
  end
end
