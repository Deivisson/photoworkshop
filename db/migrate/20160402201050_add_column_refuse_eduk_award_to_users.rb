class AddColumnRefuseEdukAwardToUsers < ActiveRecord::Migration
  def change
    add_column :users, :refuse_eduk_award, :boolean, null:false, default:false
  end
end
