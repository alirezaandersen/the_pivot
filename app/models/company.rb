class Company < ActiveRecord::Base

  # default_scope {where(approve: true)}
  has_many :jobs
  has_many :users, dependent: :destroy

  belongs_to :contact_us
  accepts_nested_attributes_for :contact_us, allow_destroy:true

  validates :name, uniqueness: true

  before_save :set_slug

  def set_slug
    self.slug = name.parameterize
  end

  def to_param
    slug
  end
end
