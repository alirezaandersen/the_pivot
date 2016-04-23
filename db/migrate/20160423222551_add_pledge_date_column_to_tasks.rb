class AddPledgeDateColumnToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :pledge_date, :date
  end
end
