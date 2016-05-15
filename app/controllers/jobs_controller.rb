class JobsController < ApplicationController
  def index
    company_ids = Company.select(:id).where(approve:1).ids
    @jobs = Job.find(company_ids)
  end

  def show
    @favorites
    @job = Job.find_by(title: params[:title])
  end
end
