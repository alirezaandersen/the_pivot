require 'rails_helper'

RSpec.describe Job, type: :model do
  context 'associations' do
    it { should have_many(:users_jobs) }
    it { should have_many(:users).through(:users_jobs) }
    it { should belong_to(:city) }
    it { should belong_to(:company) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
  end

  context "#set_slug" do
    it "parameterizes job title" do
      job = create(:job)
      job.update(title: "Findy's and MAus")

      job.set_slug

      expect(job.slug).to eql("findy-s-and-maus")
    end
  end

  context "#search" do
    it "searches for job titles" do
      job1, job2, job3, job4 = create_list(:job, 4)
      job1.update(title: "Developer")
      job2.update(title: "teacher")
      job3.update(title: "developer")
      job4.update(title: "Carpenter")

      search1 = Job.search("developer")
      search2 = Job.search("carpenter")

      expect(search1).to include(job1)
      expect(search1).to include(job3)
      expect(search1).to_not include(job2)
      expect(search1).to_not include(job4)

      expect(search2).to include(job4)
      expect(search2).to_not include(job1)
      expect(search2).to_not include(job2)
      expect(search2).to_not include(job3)
    end
  end
end
