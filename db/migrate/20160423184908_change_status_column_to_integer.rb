class ChangeStatusColumnToInteger < ActiveRecord::Migration
  def change
    remove_column :tasks, :status
    add_column :tasks, :status, :integer, default: 0
  end
end
