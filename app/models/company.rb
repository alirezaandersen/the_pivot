class Company < ActiveRecord::Base
  has_many :jobsrake, dependent: :destroy
  belongs_to :contact_us
  has_many :users, dependent: :destroy
  accepts_nested_attributes_for :contact_us, allow_destroy:true
  # before_validation :capitalize_name
  #
  # validates :name, presence: true,
  # uniqueness: true
  #
  # def capitalize_name
  #   name.capitalize! if name
  # end



end
