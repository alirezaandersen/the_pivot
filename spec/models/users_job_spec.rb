require 'rails_helper'

RSpec.describe UsersJob, type: :model do
  context "status helper methods" do
    it "shows status favorited" do
      users_job_one, users_job_two, users_job_three = create_list(:users_job, 3)
      users_job_two.favorited!

      expect(UsersJob.favorited).to include(users_job_two)
    end

    it "shows status applied" do
      users_job_one, users_job_two, users_job_three = create_list(:users_job, 3)
      users_job_two.applied!

      expect(UsersJob.applied).to include(users_job_two)
    end
  end
end
