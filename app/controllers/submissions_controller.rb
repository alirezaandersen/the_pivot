class SubmissionsController < ApplicationController

  def index
    @submissions = Submission.all
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
    @submission = Submission.find_by(company_name:params[:company_name])
  end

  # def create
  #   company_params = company_applications.except(:contact_us)
  #   user_params = company_applications[:contact_us].merge({password_digest: 'asdjhgfasdf'}).except(:phone_number,:description)
  #   binding.pry
  #   @company = Company.new(company_params)
  #   @company.users.create(user_params)
  # end

  def approved_submissions
    binding.pry
    company_parameters
    user_parameters
  end

  def denied_submissions

  end

  def company_parameters
    company_params[:name] = submissions_params[:company_name]
    company_params[:description] = submissions_params[:about_company]
    company_params[:logo] = submissions_params[:logo]
    company_params[:url] = submissions_params[:url]
    company_params[:size] = submissions_params[:size_of_company]
    company_params[:industry] = submissions_params[:industry]
  end

  def user_parameters
    user_params[:first_name] = submissions_params[:first_name]
    user_params[:last_name] = submissions_params[:last_name]
    user_params[:email] = submissions_params[:email]
    user_params[:password_digest] = submissions_params[:first_name]
  end

  private

  def submissions_params
    params.require(:submission).permit(:company_name, :logo, :url, :size_of_company, :industry, :about_company, :first_name, :last_name, :email, :phone_number, :description)
  end
end
