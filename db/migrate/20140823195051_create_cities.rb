class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.references :state, index: true
      t.timestamps
    end
    add_foreign_key :cities, :states, name:'cities_states'
  end
end
