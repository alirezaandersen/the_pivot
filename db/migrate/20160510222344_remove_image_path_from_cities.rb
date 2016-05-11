class RemoveImagePathFromCities < ActiveRecord::Migration
  def change
    remove_column :cities, :image_path
  end
end
