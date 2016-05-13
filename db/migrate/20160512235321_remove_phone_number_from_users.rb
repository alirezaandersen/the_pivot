class RemovePhoneNumberFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :phone_number, :integer
    remove_column :users, :description, :text
  end
end
