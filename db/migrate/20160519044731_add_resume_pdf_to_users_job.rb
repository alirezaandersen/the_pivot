class AddResumePdfToUsersJob < ActiveRecord::Migration
  def change
    add_attachment :users_jobs, :resume_pdf
  end
end
