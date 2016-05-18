class User < ActiveRecord::Base
  has_secure_password

  has_many :contact_us, class_name: ContactUs
  has_many :users_jobs
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

  def add_company(company)
    self.company_id = company.id
    save
  end

  def store_admin!
    role = Role.find_by(name: "store_admin").id
    UserRole.create(role_id: role, user_id: self.id)
  end

  def add_registered_user_role
    self.roles << Role.find_by(name: "registered_user")
  end

  def add_store_admin_role
    self.roles << Role.find_by(name: "store_admin")
  end

  def self.company_users(company_id)
    where(company_id: company_id)
  end
end
