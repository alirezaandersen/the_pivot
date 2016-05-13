require 'rails_helper'

RSpec.describe UsersJob, type: :model do
  context "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:job) }
  end

  context "#apply_jobs" do
    it "associates user with job and updates job status" do
      job_one, job_two = create_list(:job, 2)
      user = create(:user)
      UsersJob.create(user_id: user.id, job_id: job_one.id)
      resume_path = "#{Rails.root}/spec/support/sample_cv_of_failures.pdf"
      cover_letter_text = "Sample text."
      params = { resume: resume_path,
                 cover_letter: cover_letter_text,
                 job: job_two.id }

      expect(user.users_jobs.count).to eql(1)

      user_job = UsersJob.apply_to_job(params, user)

      expect(user.users_jobs.count).to eql(2)
      expect(user_job.resume).to eql(resume_path)
      expect(user_job.cover_letter).to eql(cover_letter_text)
    end
  end
end
