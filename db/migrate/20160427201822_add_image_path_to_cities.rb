class AddImagePathToCities < ActiveRecord::Migration
  def change
    add_column :cities, :image_path, :string
  end
end
