class JobsController < ApplicationController
  include ApplicationHelper

  def index
    # company_ids = Company.select(:id).where(approve:1).ids
    #@jobs = Job.find(company_ids)
    job = Job.all
    # approved_jobs = Job.find(company_ids)
    # binding.pry
    # @jobs = approved_jobs.paginate(:page => params[:page], :per_page => 6)
    @jobs = job.paginate(:page => params[:page], :per_page => 6)
  end

  def store_jobs
    @company_name = if params[:company_id].nil?
                      Company.find(job_params[:company_id]).name
                    else
                      Company.find(params[:company_id]).name
                    end
    @jobs = Job.where(company_id: params[:company_id])
  end

  def show
    @favorites
    @job = Job.find_by(title: params[:title])
  end

  def new
    @company_id = params[:company_id] if current_user.platform_admin?
    @company_id = current_user.company_id if current_user.store_admin?
    flash[:error] = "Admin is missing a company id" if @company_id.nil?
    @job = Job.new
  end

  def create
    if (current_user.store_admin? && (current_user.company_id == job_params[:company_id].to_i)) || current_user.platform_admin?
      @job = Job.create(job_params)
    else
      flash[:error] = "No Trolls Allowed!"
    end
    redirect_to company_job_path(@job.company, @job)
  end

  def edit
    @job = Job.find(params[:id])
    @company_id = @job.company_id
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      flash[:success] = "#{@job.title} has been updated"
      redirect_to store_jobs_path(@job.company_id)
    else
      flash.now[:error] = "Invalid Information"
      render :now
    end
  end

  private

  def job_params
    params.require(:job).permit(:title,
                                :department,
                                :years_of_experience,
                                :education,
                                :job_type,
                                :salary,
                                :description,
                                :company_id)
  end


end
