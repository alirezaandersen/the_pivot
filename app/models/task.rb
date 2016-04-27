class Task < ActiveRecord::Base
  has_many :commitments
  has_many :volunteers, through: :commitments
  belongs_to :city

  validates :name, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :hours, presence: true
  validates :image_path, presence: true
  validates :city_id, presence: true

  enum status: %w(active retired pledged pending cancelled completed)

  def display_time
    self.start_time.strftime('%l:%M %p')
  end

  def self.pledged
    where(status: 2)
  end

  def self.pending
    where(status: 3)
  end

  def self.completed
    where(status: 5)
  end

end
