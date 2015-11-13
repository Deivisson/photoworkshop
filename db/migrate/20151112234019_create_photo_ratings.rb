class CreatePhotoRatings < ActiveRecord::Migration
  def change
    create_table :photo_ratings do |t|
      t.references :photo, index: true, foreign_key: true
      t.references :rating_criterium, index: true, foreign_key: true
      t.integer :score, nil:false, default:0
      t.timestamps null: false
    end
  end
end
