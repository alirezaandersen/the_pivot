require 'rails_helper'

RSpec.describe ContactUs, type: :model do
  context "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:company) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:phone_number) }
    it { is_expected.to validate_presence_of(:description) }
  end

  # context "#remove_inquiry" do
  #   it "removes customer inquiry" do
  
  #   end
  # end
end
