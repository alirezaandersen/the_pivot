class Company < ActiveRecord::Base
  has_many :jobs
  belongs_to :contact_us
  has_many :users
  accepts_nested_attributes_for :contact_us, allow_destroy:true


  # def approval_process(@company)
  #   if @company.approve
  #   end
  # end


end
