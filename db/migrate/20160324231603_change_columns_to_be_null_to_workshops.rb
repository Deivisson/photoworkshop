class ChangeColumnsToBeNullToWorkshops < ActiveRecord::Migration
  def change
  	change_column :workshops, :start_date, :date, null:true
  	change_column :workshops, :end_date, :date, null:true
  end
end
