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

    # it "can return total number of all added jobs" do
    #   favorites = Favorites.new({"1" => 1})
    #
    #   favorites.add_job(2)
    #   favorites.add_job(3)
    #
    #   expect(favorites.total).to eql(3)
    # end

    # it "can total hours of all jobs" do
    #   city = create(:city_with_jobs)
    #   favorites = Favorites.new({})
    #   city.jobs.each do |job|
    #     favorites.add_job(job.id)
    #   end
    #   expect(favorites.total_hours).to eql(6)
    # end

    it "can remove a job from the favorites" do
      jobs = create(:jobs)
      favorites = Favorites.new({})
      jobs.each do |job|
        favorites.add_job(job.id)
      end

      expect(favorites.contents).to eql({"1" => 1, "2" => 1, "3" => 1})
      # expect(favorites.total_hours).to eql(6)
      favorites.remove_job(jobs.first.id)
      expect(favorites.contents).to eql({"2" => 1, "3" => 1})
      # expect(favorites.total_hours).to eql(5)
    end
  end
end
