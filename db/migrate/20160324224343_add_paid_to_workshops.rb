class AddPaidToWorkshops < ActiveRecord::Migration
  def change
    add_column :workshops, :paid, :boolean, null:false, default:false
  end
end
