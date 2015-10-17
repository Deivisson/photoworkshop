class CreateCategoriesUsers < ActiveRecord::Migration
  def change
  	create_table :categories_users, id:false do |t|
      t.references :user, index: true
      t.references :category, index: true
      t.timestamps
    end
  end
end
