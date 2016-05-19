class ContactUs < ActiveRecord::Base

  belongs_to :user
  belongs_to :company

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true, length: { is: 10, message: "Phone number %(value) can only be 10 digits" }
  validates :description, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create
end
