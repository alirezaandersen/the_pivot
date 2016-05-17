class ChangeApplicationColumnsInUsersJob < ActiveRecord::Migration
  def change
    remove_column :users_jobs, :resume
    remove_column :users_jobs, :cover_letter
    add_column :users_jobs, :resume, :string
    add_column :users_jobs, :cover_letter, :string
  end
end
