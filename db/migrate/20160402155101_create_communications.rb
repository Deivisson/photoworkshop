class CreateCommunications < ActiveRecord::Migration
  def change
    create_table :communications do |t|
      t.string :description, null:false
      t.string :partial_name, null:false
      t.datetime :expiration_date
      t.timestamps null: false
    end
  end
end
