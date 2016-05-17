class Company < ActiveRecord::Base
  has_many :jobs

  validates :name, uniqueness: true

  before_save :set_slug

  def set_slug
    self.slug = name.parameterize
  end

  def to_param
    slug
  end
end
