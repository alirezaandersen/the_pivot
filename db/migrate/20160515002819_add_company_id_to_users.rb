class AddCompanyIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :company_id, :integer, index: true, foreign_key: true
  end
end
