class AddWorkshopPlanToWorkshops < ActiveRecord::Migration
  def change
    add_reference :workshops, :workshop_plan, index: true, foreign_key: true
  end
end
