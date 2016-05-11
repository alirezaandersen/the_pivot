require 'rails_helper'

RSpec.feature "Visitor can view a job page" do
  scenario "they can see job details" do
    city = create(:city_with_jobs)
    job = city.jobs.first

    visit jobs_path
    within(page.all("#job-snippet")[0]) do
      click_link("#{job.title}")
    end

    expect(page).to have_current_path job_path(job.title)
    expect(page).to have_content job.company.logo

    within("#job-text-box") do
      expect(page).to have_content job.company.name
      expect(page).to have_content job.title
      expect(page).to have_content job.city.name_and_state
      expect(page).to have_content job.education
      expect(page).to have_content job.years_of_experience
      expect(page).to have_content job.department
      expect(page).to have_content "#{job.salary} USD"
      expect(page).to have_content job.description
      expect(page).to have_link "APPLY"
      expect(page).to have_link "FAVORITE"
    end
  end
end
