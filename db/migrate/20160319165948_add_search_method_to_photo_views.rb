class AddSearchMethodToPhotoViews < ActiveRecord::Migration
  def change
    add_column :photo_views, :search_method, :integer, nil:false
  end
end
