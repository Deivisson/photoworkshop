class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.references :user, index: true
      t.string :description, null:false, limit:200
      t.text :details
      t.date :start_date, null:false
      t.date :end_date, null:false
      t.integer :vacancies_number
      t.decimal :value
      t.string :prerequisite
      t.string :goal
      t.string :target_audience
      t.text :term
      t.timestamps
    end
    add_foreign_key :workshops, :users, name:'workshops_user'
  end
end
