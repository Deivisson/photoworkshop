class CreateCommunicationsUsers < ActiveRecord::Migration
  def change
    create_table :communications_users, :id => false  do |t|
    	t.references :communication, null:false
    	t.references :user, null:false
    end
  end
end
