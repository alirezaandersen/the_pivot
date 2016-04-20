class City < ActiveRecord::Base
  has_many :tasks

  validates :name, presence: true
  validates :state, presence: true

  # before_save :set_slug
  #
  # def set_slug
  #   self.slug = name.parameterize
  # end
  #
  # def to_param
  #   slug
  # end

end
