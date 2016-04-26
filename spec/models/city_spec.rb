require 'rails_helper'

RSpec.describe City, type: :model do
  context "#to_map" do
    it "formats string for map" do
      city = create(:city_with_tasks)
      task =  Task.create(name: "Name",
                    description: "Description",
                    date:        "11/04/2016",
                    start_time:  "3:00 PM",
                    hours:       3,
                    image_path:  "https://robohash.org/3",
                    city_id:      city.id,
                    address:  "942 Hazel Court, Denver, CO 80204")
      task =  Task.create(name: "Name",
                    description: "Description",
                    date:        "11/04/2016",
                    start_time:  "3:00 PM",
                    hours:       3,
                    image_path:  "https://robohash.org/3",
                    city_id:      city.id,
                    address:  "1510 Blake St. Denver, CO 80202")

      expect(city.to_map).to eql("942+Hazel+Court+Denver+CO+80204|1510+Blake+St+Denver+CO+80202")
    end
  end
end
