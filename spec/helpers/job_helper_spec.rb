require 'rails_helper'

RSpec.describe JobHelper, "#saved_favorites_condition" do
  it "defines true if job is saved as applied" do
    job1, job2 = create_list(:job, 2)
    user = create(:user)
    user.roles << Role.create(name: "registered_user")
    UsersJob.create(user_id: user.id, job_id: job1.id, status: 1)
    UsersJob.create(user_id: user.id, job_id: job2.id, status: 0)

    condition1 = helper.saved_favorites_condition(user, job1.id)
    condition2 = helper.saved_favorites_condition(user, job2.id)

    expect(condition1).to eq(true)
    expect(condition2).to eq(false)
  end

  it "defines true if job is saved as favorite or applied" do
    job1, job2 = create_list(:job, 2)
    user = create(:user)
    user.roles << Role.create(name: "registered_user")
    UsersJob.create(user_id: user.id, job_id: job1.id, status: 1)
    UsersJob.create(user_id: user.id, job_id: job2.id, status: 0)

    condition1 = helper.remove_favorites_condition(user, job1.id)
    condition2 = helper.remove_favorites_condition(user, job2.id)

    expect(condition1).to eq(true)
    expect(condition2).to eq(true)
  end
end
