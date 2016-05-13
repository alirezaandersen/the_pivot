class AddPhoneNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone_number, :integer
    add_column :users, :description, :text
  end
end
