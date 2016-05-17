class Job < ActiveRecord::Base
  has_many :users_jobs
  has_many :users, through: :users_jobs
  belongs_to :city
  belongs_to :company

  validates :title, presence: true
  validates :description, presence: true

  before_save :set_slug

  enum status: %w(active retired)

  def self.search(search)
    where("title ILIKE ?", "%#{search}%")
  end

  def set_slug
    self.slug = title.parameterize
  end

  def to_param
    slug
  end
end
