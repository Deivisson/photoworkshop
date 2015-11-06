class AddColumnCurrentPointsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_points, :integer, null:false, default:0
  end
end
