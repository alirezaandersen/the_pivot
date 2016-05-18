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

    it "returns true if job is in favorites" do
      favorites = Favorites.new({})
      job1, job2, job3 = create_list(:job, 3)
      favorites.add_job(job2.id)
      favorites.add_job(job3.id)

      expect(favorites.has_job?(job1.id)).to eql(false)
      expect(favorites.has_job?(job2.id)).to eql(true)
      expect(favorites.has_job?(job3.id)).to eql(true)
    end

    it "can return total number of all added jobs" do
      favorites = Favorites.new({"1" => 1})

      favorites.add_job(2)
      favorites.add_job(3)

      expect(favorites.total).to eql(3)
    end

    it "returns jobs in favorites" do
      job1, job2, job3, job4 = create_list(:job, 4)
      favorites = Favorites.new({"1" => 1, "2" => 1, "3" => 1})
      favorited_jobs = favorites.jobs

      expect(favorited_jobs).to include(job1)
      expect(favorited_jobs).to include(job2)
      expect(favorited_jobs).to include(job3)
      expect(favorited_jobs).to_not include(job4)
    end
  end

  context "remove contents from favorites" do
    it "can remove a job from the favorites" do
      job1, job2, job3 = create_list(:job, 3)
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
