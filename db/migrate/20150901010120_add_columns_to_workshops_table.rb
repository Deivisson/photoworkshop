class AddColumnsToWorkshopsTable < ActiveRecord::Migration
  def change
  	add_column :workshops, :workload, :string, limit:50
  	add_column :workshops, :local, :string, limit:255
  	add_column :workshops, :complement, :text
		add_column :workshops, :email_subscribe, :text
    add_column :workshops, :email_matriculate, :text
  end
end
