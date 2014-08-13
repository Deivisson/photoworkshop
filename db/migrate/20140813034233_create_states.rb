class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name, :limit => 100
      t.string :short_name, :limit => 2
      t.references :country, index: true

      t.timestamps
    end
    add_foreign_key :states, :countries, name:'states_countries'
  end
end
