require 'rails_helper'

RSpec.describe Company, type: :model do
  context "associations" do
    it { should have_many(:jobs) }
    it { should have_many(:users).dependent(:destroy) }
    it { should have_many(:contact_us) }
  end

  context "validations" do
    it { should validate_uniqueness_of(:name) }
  end

  context "#set_slug" do
    it "parameterizes company names" do
      company = create(:company)
      company.update(name: "Findy's and MAus")

      company.set_slug

      expect(company.slug).to eql("findy-s-and-maus")
    end
  end
end
