class CreateWorkshopMaterials < ActiveRecord::Migration
  def change
    create_table :workshop_materials do |t|
      t.references :workshop, index: true
      t.string :description, limit:100
      t.attachment :attachment
      t.timestamps
    end
    add_foreign_key :workshop_materials, :workshops, name:"workshop_materials_workshop"
  end
end
