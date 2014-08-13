class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :description, :limit => 40
      t.timestamps
    end
  end
end
