class DeleteUsersJobs < ActiveRecord::Migration
  def change
    drop_table :users_jobs
  end
end
