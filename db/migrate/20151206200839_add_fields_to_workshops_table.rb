class AddFieldsToWorkshopsTable < ActiveRecord::Migration
  def change
  	add_column :workshops, :allow_queued, :boolean,null:false,default:false
  	add_column :workshops, :allow_pre_enrolls, :boolean, null:false, default:true
  end
end
