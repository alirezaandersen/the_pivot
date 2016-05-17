class AddColumnContactUsIdToCompanies < ActiveRecord::Migration
  def change
    add_column :contact_us, :company_id, :integer, index: true, foreign_key: true
  end
end
