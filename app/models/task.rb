class Task < ActiveRecord::Base
  belongs_to :volunteer
  belongs_to :city

  validates :name, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :hours, presence: true
  validates :image_path, presence: true
  validates :city_id, presence: true
end