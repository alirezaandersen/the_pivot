class CreateContactUs < ActiveRecord::Migration
  def change
    create_table :contact_us do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :phone_number
      t.text :description
      t.references :user, index: true, foreign_key: true    end
  end
end
