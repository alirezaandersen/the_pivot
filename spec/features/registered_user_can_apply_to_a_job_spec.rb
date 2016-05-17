  require 'rails_helper'

RSpec.feature "Registered job seeker can apply to a job" do
  scenario "they must be logged in to apply to a job" do
    registered_user = create(:user)
    job = create(:job)
    job.company.update(approve: true)
    file_path = "#{Rails.root}/spec/support/sample_cv_of_failures.pdf"
    text = "This is the body of the cover letter.\nNot entirely sure what to right.\nSincerely,\nBenjamin Franklin"
    flash_text = "You have applied for #{job.title} with #{job.company.name}."

    visit company_job_path(job.company, job)
    click_link("LOGIN TO APPLY")

    expect(page).to have_current_path login_path

    login_user(registered_user)

    expect(page).to have_current_path dashboard_path
    visit company_job_path(job.company, job)
    click_link("APPLY")
    within(".job-form") do
      attach_file("users_jobs[resume]", file_path)
      fill_in "users_jobs[cover_letter]", with: text
      click_button("Submit")
    end

    expect(page).to have_current_path dashboard_path
    expect(page).to have_content flash_text
  end

  scenario "they can submit a job application when already logged in" do
    registered_user = create(:user)
    job = create(:job)
    file_path = "#{Rails.root}/spec/support/sample_cv_of_failures.pdf"
    text = "This is the body of the cover letter.\nNot entirely sure what to right.\nSincerely,\nBenjamin Franklin"
    flash_text = "You have applied for #{job.title} with #{job.company.name}."

    visit company_job_path(job.company, job)
    login_user(registered_user)

    visit company_job_path(job.company, job)
    click_link("APPLY")
    within(".job-form") do
      attach_file("users_jobs[resume]", file_path)
      fill_in "users_jobs[cover_letter]", with: text
      click_button("Submit")
    end

    expect(page).to have_current_path dashboard_path
    expect(page).to have_content flash_text
  end

  scenario "they can access their own jobs index and visit the job page for which they've applied to" do
    registered_user = create(:user)
    jobs = create_list(:job, 2)
    job_one = jobs.first
    jobs.each do |job|
      users_job_with_resume(registered_user, job)
    end
    login_user(registered_user)

    expect(page).to have_current_path dashboard_path

    within(".dashboard") do
      expect(page).to have_link "Jobs I've Applied To"

      click_link("Jobs I've Applied To")
    end

    expect(page).to have_current_path my_jobs_path

    within(page.all(".card-action")[0]) do
      click_link("View opportunity details")
    end

    expect(page).to have_current_path company_job_path(job_one.company, job_one)

    within("#job-text-box") do
      expect(page).to have_button "APPLIED"
    end
  end
end
