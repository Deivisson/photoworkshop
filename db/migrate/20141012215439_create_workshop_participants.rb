class CreateWorkshopParticipants < ActiveRecord::Migration
  def change
    create_table :workshop_participants do |t|
      t.references :user, index: true
      t.references :workshop, index: true
      t.timestamps
    end
    add_foreign_key :workshop_participants, :users, name:'workshop_participants_user'
    add_foreign_key :workshop_participants, :workshops, name:'workshop_participants_workshop'
  end
end
