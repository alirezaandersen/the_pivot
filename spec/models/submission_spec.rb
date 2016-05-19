require 'rails_helper'

RSpec.describe Submission, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.not_to allow_value(1234567).for(:phone_number) }
    it { is_expected.to allow_value(1234567890).for(:phone_number) }
    it { is_expected.not_to allow_value(12345678).for(:phone_number) }
    it { is_expected.to allow_value("example@example.com").for(:email) }
    it { is_expected.not_to allow_value("example@example").for(:email) }
  end
end
