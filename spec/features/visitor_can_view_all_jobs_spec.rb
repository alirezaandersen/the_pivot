require 'rails_helper'

RSpec.feature "Visitor can view all jobs" do
  scenario "they see a listing of available jobs" do
    city = create(:city_with_jobs)

    city_jobs = city.jobs

    visit root_path

    within("#nav-bar-job") do
      click_link("JOBS")
    end

    expect(page).to have_current_path jobs_path
    city_jobs.each_with_index do |job, index|
      within(page.all("#job-snippet")[index]) do
        expect(page).to have_content job.company.name
        expect(page).to have_content job.title
        expect(page).to have_content city.name_and_state
        expect(page).to have_content job.description
      end
    end
  end
end
