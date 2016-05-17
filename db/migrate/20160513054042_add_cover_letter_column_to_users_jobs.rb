class AddCoverLetterColumnToUsersJobs < ActiveRecord::Migration
  def change
    add_column :users_jobs, :cover_letter, :text
  end
end
