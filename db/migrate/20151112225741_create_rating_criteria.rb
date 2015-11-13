class CreateRatingCriteria < ActiveRecord::Migration
  def change
    create_table :rating_criteria do |t|
      t.string :i18n_key, null:false
      t.timestamps null: false
    end
  end
end
