class ContactUs < ActiveRecord::Base

  has_many :users

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true
  validates :description, presence: true

end
