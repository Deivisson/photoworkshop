class AddConfirmedToWorkshopParticipants < ActiveRecord::Migration
  def change
    add_column :workshop_participants, :confirmed, :boolean, null:false, default:false
  end
end
