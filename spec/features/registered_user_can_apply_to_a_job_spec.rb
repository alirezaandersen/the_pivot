require 'rails_helper'

RSpec.feature "Registered job seeker can apply to a job" do
  scenario "they must be logged in to apply to a job" do
    registered_user = create(:user)
    job = create(:job)
    file_path = "#{Rails.root}/spec/support/sample_cv_of_failures.pdf"
    text = "This is the body of the cover letter.\nNot entirely sure what to right.\nSincerely,\nBenjamin Franklin"
    flash_text = "You have applied for #{job.title} with #{job.company.name}."
    visit job_path(job.title)

    click_link("LOGIN TO APPLY")

    expect(page).to have_current_path login_path

    login_user(registered_user)

    # figure out how to redirect to job page; troubleshoot why request.referrer didn't work
    # expect(page).to have_current_path job_path(job.title)
    expect(page).to have_current_path dashboard_path

    visit job_path(job.title)

    within(".job-form") do
      attach_file("users_jobs[resume]", file_path)
      fill_in "users_jobs[cover_letter]", with: text
      click_button("Submit")
    end

    expect(page).to have_current_path dashboard_path
    expect(page).to have_content flash_text
  end

  scenario "they can submit a job application when already logged in" do
    # create and log in user
    # create a job
    # visit specific job
    # click on "Apply"
    # they can redirected back to dashboard
  end

  scenario "they can access their own jobs index and visit the job page for which they've applied to" do
    # create and log in user
    # create lists of jobs associated with user
    # user visits their jobs index
    # user clicks on a job
    # user is redirected to specifc job page
    # user will see "Applied" button
  end

  scenario "they cannot apply to the same job at the same company twice" do
    # create and log in user
    # create lists of jobs associated with user
    # user visits specific job page they have applied to
    # user clicks on "Applied" button and they just remain on the page
  end
end
