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
    it { is_expected.not_to allow_value(1234567).for(:phone_number) }
    it { is_expected.to allow_value(1234567890).for(:phone_number) }
    it { is_expected.not_to allow_value(12345678).for(:phone_number) }
    it { is_expected.to allow_value("example@example.com").for(:email) }
    it { is_expected.not_to allow_value("example@example").for(:email) }
  end
end
