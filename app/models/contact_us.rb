class ContactUs < ActiveRecord::Base

  belongs_to :user
  belongs_to :company

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true
  validates :description, presence: true
end
