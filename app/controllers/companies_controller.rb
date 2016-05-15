class CompaniesController < ApplicationController
  def index
    companies = Company.all
    @companies = companies.paginate(:page => params[:page], :per_page => 6)
  end

  def show
    @company = Company.find(params[:id])
  end
end
