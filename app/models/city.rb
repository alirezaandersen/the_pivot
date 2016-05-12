class City < ActiveRecord::Base
  has_many :jobs

  validates :name, presence: true
  validates :state, presence: true

  before_save :set_slug

  def set_slug
    self.slug = name.parameterize
  end

  def to_param
    slug
  end

  # def to_map
  #   addresses = tasks.map {|task| task.format_address }.compact
  #   addresses.join("%7C")
  # end

  def name_and_state
    "#{name}, #{state}"
  end
end
