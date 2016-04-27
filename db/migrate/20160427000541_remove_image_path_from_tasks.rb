class RemoveImagePathFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :image_path
  end
end
