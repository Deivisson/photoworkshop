class CreateWorkshopParticipants < ActiveRecord::Migration
  def change
    create_table :workshop_participants do |t|
      t.references :user, index: true
      t.references :workshop, index: true
      t.timestamps
    end
  end
end
