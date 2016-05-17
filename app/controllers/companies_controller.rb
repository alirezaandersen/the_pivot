class CompaniesController < ApplicationController

  def index
    approved_companies = Company.where(approve: 1) || []
    #@companies = Company.where(approve: 1) || []
    @companies = approved_companies.paginate(:page => params[:page], :per_page => 6)
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
  end

  def show
    # binding.pry
    @company = Company.find_by(slug: params[:company_name])
      # @company = Company.find(params[:id])
  end

  def edit
    @company = Company.find(params[:company_id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update(company_applications)
      flash[:success] = "#{@company.name} has been updated"
      redirect_to @company
    else
      flash.now[:error] = "Invalid Information"
      render :now
    end
  end

  def active_companies
    # binding.pry
    @companies = Company.where(approve: true) || []
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
    @pending_company = Company.find(params[:id])
  end

  private

  def company_applications
  params.require(:company).permit(:name,:logo, :url, :size, :industry, :description,  contact_us: [:first_name, :last_name, :email, :phone_number, :description])
  end
end
