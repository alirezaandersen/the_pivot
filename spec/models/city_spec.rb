require 'rails_helper'

RSpec.describe City, type: :model do
  context "#to_map" do
    it "formats string for map" do
      city = create(:city_with_tasks)

      expect(city.to_map).to eql("107+Main+Street+Denver+CO+1070204%7C106+Main+Street+Denver+CO+1060204%7C105+Main+Street+Denver+CO+1050204%7C104+Main+Street+Denver+CO+1040204")
    end
  end
end
