class Job < ActiveRecord::Base
  has_many :users_jobs
  has_many :users, through: :users_jobs
  belongs_to :city
  belongs_to :company

  validates :title, presence: true
  validates :description, presence: true

  enum status: %w(active retired)
end
