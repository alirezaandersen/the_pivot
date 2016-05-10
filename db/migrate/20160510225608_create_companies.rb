class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.text :description
      t.text :logo
      t.text :url
      t.integer :size
      t.string :industry

      t.timestamps null: false
    end
  end
end
