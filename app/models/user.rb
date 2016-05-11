class User < ActiveRecord::Base
  has_secure_password
  has_many :users_jobs
  has_many :jobs, through: :users_jobs

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  enum role: %w(default admin)
end
