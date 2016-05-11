require 'rails_helper'

RSpec.describe City, type: :model do
  context "associations" do
    it { should have_many(:jobs) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:state) }
  end

  context "#name_and_state" do
    it "formats name and state" do
      city = create(:city)

      name = city.name
      state = city.state

      expect(city.name_and_state).to eql("#{name}, #{state}")
    end
  end

  # context "#to_map" do
  #   it "formats string for map" do
  #     city = create(:city_with_tasks)
  #
  #     expect(city.to_map).to eql("107+Main+Street+Denver+CO+10204%7C106+Main+Street+Denver+CO+10204%7C105+Main+Street+Denver+CO+10204%7C104+Main+Street+Denver+CO+10204")
  #   end
  # end
end
