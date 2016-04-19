class AddImagePathToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :image_path, :text
  end
end
