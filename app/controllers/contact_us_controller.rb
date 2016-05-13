class ContactUsController < ApplicationController

  def index

  end

  def new
    @contact = ContactUs.new
  end

  def create
    @contact = ContactUs.new(contact_params)
    if @contact.save
      flash[:notice] = "Thanks for the feedback, we'll be in touch as soon as we can"
      redirect_to root_path
    else
      flash.now[:error] = "Invalid Info. Please try again."
      render :new
    end
  end


  private

  def contact_params
    params.require(:contact_us).permit(
                            :first_name,
                            :last_name,
                            :email,
                            :phone_number,
                            :description)
                end

end
