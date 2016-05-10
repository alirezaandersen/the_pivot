class RenameTasks < ActiveRecord::Migration
  def change
    rename_table :tasks, :jobs
  end
end
