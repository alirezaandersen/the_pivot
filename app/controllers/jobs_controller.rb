class JobsController < ApplicationController
  def index
    company_ids = Company.select(:id).where(approve:1).ids
    @jobs = Job.find(company_ids)
  end

  def show
    @favorites
    @job = Job.find_by(title: params[:title])
  end

  def new
    # binding.pry
    @company_id = params[:company_id] if current_user.platform_admin?
    @company_id = current_user.company_id if current_user.store_admin?
    flash[:error] = "Admin is missing a company id" if @company_id.nil?
    @job = Job.new
  end

  def create
    # binding.pry
    if (current_user.store_admin? && (current_user.company_id == job_params[:company_id].to_i)) || current_user.platform_admin?
      @job = Job.create(job_params)
    binding.pry
    else
      flash[:error] = "No Trolls Allowed!"
    end

    redirect_to job_path(@job.title)
  end

  def job_params
    params.require(:job).permit(:title,
                                :description,
                                :years_of_experience,
                                :education,
                                :job_type,
                                :salary,
                                :description,
                                :company_id)
  end


end
