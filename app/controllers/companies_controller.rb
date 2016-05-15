class CompaniesController < ApplicationController
  def index
    @companies = Company.where(approve: 1) || []
  end

  def new
    @company = Company.new
    @contact_us = ContactUs.new
  end

  def create
    company_params = company_applications.except(:contact_us)
    user_params = company_applications[:contact_us].merge({password_digest: 'asdjhgfasdf'}).except(:phone_number,:description)
    binding.pry
    @company = Company.new(company_params)
    @company.users.create(user_params)
  end

  def show
    @company = Company.find(params[:id])
  end

  def pending_index
    @pending_companies = Company.where("approve=?",false)
  end

  def pending_show

    binding.pry
    @pending_company = Company.find(params[:id])
  end

  private

  def company_applications
  params.require(:company).permit(:name,:logo, :url, :size, :industry, :description,  contact_us: [:first_name, :last_name, :email, :phone_number, :description])
  end
end
