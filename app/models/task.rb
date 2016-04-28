class Task < ActiveRecord::Base
  has_attached_file :image, styles: { medium: "300x300>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  before_save :set_default_image

  has_many :commitments
  has_many :volunteers, through: :commitments
  belongs_to :city

  validates :name, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :hours, presence: true
  validates :city_id, presence: true
  validates :address, presence: true
  validates :zip_code, presence: true, length: { is: 5}

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

  def format_address
    compiled = "#{address}, #{city.name_and_state} #{zip_code}" unless address.nil?
    compiled.gsub(/\W+/, "+")
  end

  def link
    "<a href=\"/tasks/#{id}\">#{name}</a>"
  end

  def set_default_image
    self.update_attributes(image: File.open("#{Rails.root}/app/assets/images/full_placeholder.png")) if self.image_file_name.nil?
  end

end
