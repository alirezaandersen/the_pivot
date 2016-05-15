class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :company_name
      t.string :logo
      t.string :url
      t.integer :size_of_company
      t.string :industry
      t.string :about_company
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.string :description
      t.integer :approval

      t.timestamps null: false
    end
  end
end
