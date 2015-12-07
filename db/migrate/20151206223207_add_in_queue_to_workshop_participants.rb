class AddInQueueToWorkshopParticipants < ActiveRecord::Migration
  def change
    add_column :workshop_participants, :in_queue, :boolean, null:false, default:false
  end
end
