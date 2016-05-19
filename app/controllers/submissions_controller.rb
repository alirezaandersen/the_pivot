class SubmissionsController < ApplicationController

  def index
    @title = "Pending Submissions"
    @submissions = Submission.where(approval: 0) || []
  end

  def new
    @submission = Submission.new
  end

  def create
    @submission = Submission.new(submissions_params)
    if @submission.save
      flash[:success] = "Thank you for your interest. A Ziba specialist will reach out to you soon"
      redirect_to root_path
    else
      flash[:error] = "Invalid Info. Please try again"
      render :new
    end
  end

  def show
    @submission = Submission.find_by(company_name:params[:company_name])
  end

  def approved_index
    @title = "Approved Submissions"
    @submission = Submission.where(approval: 1) || []
  end

  def approved_submissions
    submission = Submission.find_by(company_name: params[:company_name])
    @company = submission.create_company
    user = submission.create_user
    user.add_company(@company)
    user.store_admin!
    approved_status
  end

  def denied_index
    @title = "Denied Submissions"
    @submission = Submission.where(approval: 2) || []
  end

  def denied_submissions
    Submission.find_by(company_name: params[:company_name]).update(approval: 2)
    redirect_to companies_denied_path
  end

  def approved_status
    status = Submission.find_by(company_name:@company.name)
    status.update(approval: 1) if !status.nil?
    flash.now[:error] = "You can't approve the same Submission Again"
    redirect_to companies_approved_path
  end


  private


  def submissions_params
    params.require(:submission).permit(:company_name, :logo, :url, :size_of_company, :industry, :about_company, :first_name, :last_name, :email, :phone_number, :description, :authenticity_token)
  end
end
