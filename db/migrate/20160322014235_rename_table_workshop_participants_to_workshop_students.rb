class RenameTableWorkshopParticipantsToWorkshopStudents < ActiveRecord::Migration
  def change
    remove_foreign_key :workshop_participants, name:'workshop_participants_user'
    remove_foreign_key :workshop_participants, name:'workshop_participants_workshop'
    rename_table :workshop_participants, :workshop_students
    add_foreign_key :workshop_students, :users, name:'workshop_students_user'
    add_foreign_key :workshop_students, :workshops, name:'workshop_students_workshop'
  end
end
