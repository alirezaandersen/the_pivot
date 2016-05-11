class ReplaceColumnsInJobs < ActiveRecord::Migration
  def change
    rename_column :jobs, :name, :title
    rename_column :jobs, :hours, :years_of_experience
    rename_column :jobs, :address, :education
    rename_column :jobs, :image_file_size, :salary
    rename_column :jobs, :image_content_type, :department
    rename_column :jobs, :zip_code, :job_type


    remove_column :jobs, :image_file_name
    remove_column :jobs, :pledge_date
    remove_column :jobs, :start_time
    remove_column :jobs, :date
    remove_column :jobs, :image_updated_at
  end
end
