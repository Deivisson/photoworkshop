class CreateAdminCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name, :limit => 100
      t.timestamps
    end
  end
end
