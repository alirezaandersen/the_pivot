class ChangeApplicationColumnsToPreviousTypeInUsersJob < ActiveRecord::Migration
  def change
    remove_column :users_jobs, :resume
    remove_column :users_jobs, :cover_letter
    add_column :users_jobs, :resume, :text
    add_column :users_jobs, :cover_letter, :text
  end
end
