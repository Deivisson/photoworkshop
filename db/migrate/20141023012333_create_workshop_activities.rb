class CreateWorkshopActivities < ActiveRecord::Migration
  def change
    create_table :workshop_activities do |t|
    	t.references :workshop, index: true
      t.string :description, limit:100, null:false
      t.text :details
      t.integer :status, null:false, default:0
      t.date :limit_date
      t.timestamps
    end
    add_foreign_key :workshop_activities, :workshops, name:"workshop_activities_workshop"
  end
end
