class ChangeStatusColumnToIntegerInUsersJob < ActiveRecord::Migration
  def change
    remove_column :users_jobs, :status
    add_column :users_jobs, :status, :integer, default: 0
  end
end
