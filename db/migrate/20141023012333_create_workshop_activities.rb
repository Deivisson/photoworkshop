class CreateWorkshopActivities < ActiveRecord::Migration
  def change
    create_table :workshop_activities do |t|
      t.string :description
      t.text :details
      t.integer :status
      t.date :limit_date

      t.timestamps
    end
  end
end
