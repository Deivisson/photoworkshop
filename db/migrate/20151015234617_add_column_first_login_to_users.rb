class AddColumnFirstLoginToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :first_login, :boolean, nil:false, default:true
  end
end
