require 'rails_helper'

RSpec.describe Company, type: :model do
  context "associations" do
    it { should have_many(:jobs) }
    it { should have_many(:users).dependent(:destroy) }
    it { should have_many(:contact_us) }
    # it { should accept_nested_attributes_for(:contact_us).(allow_destroy: true) }
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

  # context "#company_status" do
  #   it "finds company by name and updates approve status" do
  #     company1, company2, company3 = create_list(:company, 3)
  #
  #     Company.company_status(company1.name, true)
  #     Company.company_status(company3.name, true)

      # expect(company1.approve).to eql(false)
      # expect(company2.approve).to eql(true)
      # expect(company3.approve).to eql(false)

    # end
  # end
end
