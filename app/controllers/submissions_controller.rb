class SubmissionsController < ApplicationController

  def index
    @title = "Pending Submissions"
    @submissions = Submission.where(approval: 0) || []
    # binding.pry
  end

  def new
    @submission = Submission.new
  end

  def create
    # binding.pry
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
    # binding.pry
  end

  def approved_submissions
      @company = Company.create(company_info)
      @user = User.create(user_info.merge(company_id:@company[:id]))
      role = Role.find_by(name:"store_admin")
      UserRole.create(role_id:role[:id],user_id:@user[:id])

      status = Submission.find_by(company_name:@company.name)
      status.update(approval: 1) if !status.nil?

      redirect_to companies_approved_path
  end

  def denied_index
    @title = "Denied Submissions"
    @submission = Submission.where(approval: 2) || []
  end

  def denied_submissions
    # binding.pry
    Submission.find_by(company_name: params[:company_name]).update(approval: 2)
    redirect_to companies_denied_path
  end

  def submissions_parser
    Submission.find_by(company_name: params[:company_name])
  end

  def company_info
    company_params = {}
    company_params[:name] = submissions_parser.company_name
    company_params[:description] = submissions_parser.about_company
    company_params[:logo] = submissions_parser.logo
    company_params[:url] = submissions_parser.url
    company_params[:size] = submissions_parser.size_of_company
    company_params[:industry] = submissions_parser.industry
    company_params[:approve] = true
    company_params
  end

  def user_info
    user_params = {}
    user_params[:first_name] = submissions_parser[:first_name]
    user_params[:last_name] = submissions_parser[:last_name]
    user_params[:email] = submissions_parser[:email]
    user_params[:password_digest] = "password_digest"
    user_params
  end

  private

  def submissions_params
    params.require(:submission).permit(:company_name, :logo, :url, :size_of_company, :industry, :about_company, :first_name, :last_name, :email, :phone_number, :description, :authenticity_token)
  end
end
