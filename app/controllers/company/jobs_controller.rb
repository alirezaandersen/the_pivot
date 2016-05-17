class Company::JobsController < Company::BaseController
  def show
    company = Company.find_by(slug: params[:company_name])
    @job = Job.find_by(slug: params[:job_title], company_id: company.id)
  end
end
