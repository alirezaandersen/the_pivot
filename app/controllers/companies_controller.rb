class CompaniesController < ApplicationController

  def index
    @companies = Company.where(approve: 1) || []
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
  end

  def show
    @company = Company.find(params[:id])
  end

  def active_companies
    @companies = Company.where(approve: 1) || []
  end

  def activate_company
    @company = Company.find_by(name: params[:company_name]).update(approve: true)
    redirect_to active_companies_path
  end

  def inactive_companies
    @companies = Company.where(approve: 0) || []
  end

  def inactivate_company
    @company = Company.find_by(name: params[:company_name]).update(approve: false)
    redirect_to inactive_companies_path
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
