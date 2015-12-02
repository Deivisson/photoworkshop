class AddColumnCssClassToRatingCriteriaTable < ActiveRecord::Migration
  def change
  	add_column :rating_criteria, :css_class, :string, length: 30
  end
end
