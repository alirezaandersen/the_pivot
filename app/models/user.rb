class User < ActiveRecord::Base
  has_secure_password

  has_many :users_jobs
  has_many :contact_us
  has_many :user_roles
  has_many :jobs, through: :users_jobs
  has_many :roles, through: :user_roles

  belongs_to :company

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  validates_confirmation_of :password

  def platform_admin?
    roles.exists?(name: "platform_admin")
  end

  def store_admin?
    roles.exists?(name: "store_admin")
  end

  def registered_user?
    roles.exists?(name: "registered_user")
  end
end
