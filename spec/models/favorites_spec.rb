require 'rails_helper'

RSpec.describe Favorites, type: :model do
  context "add contents to favorites" do
    it "can have contents" do
      favorites = Favorites.new({"1" => 1})

      expect(favorites.contents).to eql({"1" => 1})
    end

    it "can add jobs to favorites" do
      favorites = Favorites.new({"1" => 1})

      favorites.add_job(2)
      favorites.add_job(3)

      expect(favorites.contents).to eql({"1" => 1, "2" => 1, "3" => 1})
    end

    it "can return total number of all added jobs" do
      favorites = Favorites.new({"1" => 1})

      favorites.add_job(2)
      favorites.add_job(3)

      expect(favorites.total).to eql(3)
    end

    it "can remove a job from the favorites" do
      job1 = create(:job)
      job2 = create(:job)
      job3 = create(:job)
      favorites = Favorites.new({})

      favorites.add_job(job1.id)
      favorites.add_job(job2.id)
      favorites.add_job(job3.id)


      expect(favorites.contents).to eql({"1" => 1, "2" => 1, "3" => 1})
      favorites.remove_job(job1.id)
      expect(favorites.contents).to eql({"2" => 1, "3" => 1})
    end
  end
end
