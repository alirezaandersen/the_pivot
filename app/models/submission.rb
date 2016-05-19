class Submission < ActiveRecord::Base

  validates :email, presence: true,
    uniqueness: true

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates :phone_number, presence: true, length: { is: 10, message: "Phone number %(value) can only be 10 digits" }


  enum approval:["pending", "approved", "denied"]

  def create_company
    Company.create(company_info)
  end

  def company_info
    company_params = {}
    company_params[:name] = company_name
    company_params[:description] = about_company
    company_params[:logo] = logo
    company_params[:url] = url
    company_params[:size] = size_of_company
    company_params[:industry] = industry
    company_params[:approve] = true
    company_params
  end

  def create_user
    User.create(user_info)
  end

  def user_info
    user_params = {}
    user_params[:first_name] = first_name
    user_params[:last_name] = last_name
    user_params[:email] = email
    user_params[:password_digest] = "password_digest"
    user_params
  end

end
