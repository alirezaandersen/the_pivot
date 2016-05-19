class Company < ActiveRecord::Base
  has_many :jobs
  has_many :users, dependent: :destroy
  has_many :contact_us, class_name: ContactUs
  accepts_nested_attributes_for :contact_us, allow_destroy: true

  validates :name, uniqueness: true

  before_save :set_slug

  def set_slug
    self.slug = name.parameterize
  end

  def to_param
    slug
  end
end
