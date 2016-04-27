class RemoveVolunteerIdFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :volunteer_id
  end
end
