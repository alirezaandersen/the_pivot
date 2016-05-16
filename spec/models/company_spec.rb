require 'rails_helper'

RSpec.describe Company, type: :model do
  context "associations" do
    it { should have_many(:jobs) }
  end

  context "validations" do
    it { should validate_uniqueness_of(:name) }
  end
end
