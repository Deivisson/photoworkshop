class AddColumnUserXIdToUserPoints < ActiveRecord::Migration
  def change
    add_column :user_points, :userx_id, :integer, index:true
    add_foreign_key :user_points, :users, column: 'userx_id', name: 'user_points_user_x'
  end
end
