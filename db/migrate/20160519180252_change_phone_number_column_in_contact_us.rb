class ChangePhoneNumberColumnInContactUs < ActiveRecord::Migration
  def change
    remove_column :contact_us, :phone_number, :integer
    add_column :contact_us, :phone_number, :string
  end
end
