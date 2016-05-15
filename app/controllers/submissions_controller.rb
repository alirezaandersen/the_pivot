class SubmissionsController < ApplicationController

  def index
    @submissions = Submission.all
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
    # binding.pry
    # @submission = Submission.find(params[:id])
    @submission = Submission.find_by(company_name:params[:company_name])
    binding.pry
  end

  def approved_submissions
      # binding.pry
      @company = Company.create(company_info)
      # binding.pry
      @user = User.create(user_info.merge(company_id:@company[:id]))
      role = Role.find_by(name:"store_admin")
      UserRole.create(role_id:role[:id],user_id:@user[:id])
  end

  def denied_submissions(params)

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
    #binding.pry
    # params.require(:submission).permit(:company_name, :logo, :url, :size_of_company, :industry, :about_company, :first_name, :last_name, :email, :phone_number, :description)
    params.permit(:company_name, :logo, :url, :size_of_company, :industry, :about_company, :first_name, :last_name, :email, :phone_number, :description)

  end
end
