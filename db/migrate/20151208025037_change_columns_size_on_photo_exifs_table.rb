class ChangeColumnsSizeOnPhotoExifsTable < ActiveRecord::Migration
  def change
	  change_column :photo_exifs, :iso, :string, :limit => 100
    change_column :photo_exifs, :focal_lenght, :string, :limit => 100
    change_column :photo_exifs, :colorsapce, :string, :limit => 100
    change_column :photo_exifs, :exposuremode, :string, :limit => 100
    change_column :photo_exifs, :whitebalance, :string, :limit => 100
  end
end
