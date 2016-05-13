class User < ActiveRecord::Base
  has_secure_password
  has_many :users_job
  has_many :contact_us
  has_many :jobs, through: :users_job

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  enum role: %w(default admin)

  validates_confirmation_of :password
end
