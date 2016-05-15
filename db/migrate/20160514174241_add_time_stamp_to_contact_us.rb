class AddTimeStampToContactUs < ActiveRecord::Migration
  def change
     add_column(:contact_us, :created_at, :datetime)
     add_column(:contact_us, :updated_at, :datetime)
   end
end
