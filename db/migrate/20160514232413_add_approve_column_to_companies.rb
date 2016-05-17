class AddApproveColumnToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :approve, :boolean, :default => false
  end
end
