class RenameVolunteersToUsers < ActiveRecord::Migration
  def change
    rename_table :volunteers, :users
  end
end
