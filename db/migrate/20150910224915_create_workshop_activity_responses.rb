class CreateWorkshopActivityResponses < ActiveRecord::Migration
  def change
    create_table :workshop_activity_responses do |t|
      t.references :user, index: true
      t.references :workshop_activity, index: true
      t.timestamps
    end
  end
end
