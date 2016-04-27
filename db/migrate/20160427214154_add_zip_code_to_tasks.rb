class AddZipCodeToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :zip_code, :string
  end
end
