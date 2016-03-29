class ChangeColumnValueToWorkshops < ActiveRecord::Migration
  def change
  	change_column :workshops, :value,:decimal, precision: 10, scale: 2,null:false,default:0
  end
end
