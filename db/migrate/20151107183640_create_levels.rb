class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :i18n_key, nil:false
      t.integer :number, nil:false, default:0
      t.integer :points_from, nil:false, default:0
      t.integer :points_to, nil:false, default:0
      t.timestamps null: false
    end
  end
end
