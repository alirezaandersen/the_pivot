require 'rails_helper'

RSpec.describe ApplicationHelper, "#favorite_jobs_from_session" do
  it "associates user with job and updates status to favorited" do
    job1, job2 = create_list(:job, 2)
    user = create(:user)
    session = { job1.id.to_s => 1, job2.id.to_s => 1 }
    helper.favorite_jobs_from_session(session, user)

    expect(user.users_jobs[1].user_id).to eq(user.id)
    expect(user.users_jobs[0].user_id).to eq(user.id)

    expect(user.users_jobs[0].status).to eq("favorited")
    expect(user.users_jobs[1].status).to eq("favorited")
  end
end
