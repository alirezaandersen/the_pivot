require 'rails_helper'

RSpec.feature "Visitor can search for jobs" do
  scenario "they can search by job titles" do
    search_job = create(:job)
    all_jobs = create_list(:job, 3)
    all_jobs.push(search_job)
    visit root_path

    within(".search-container") do
      expect(page).to have_button("SEARCH")
    end

    fill_in :search, with: "#{search_job.title}"
    click_button("SEARCH")

    uri = URI.parse(current_url)

    expect(uri.path).to eql("/search/jobs")

    within("#job-snippet") do
      expect(page).to have_content search_job.company.logo
      expect(page).to have_content search_job.company.name
      expect(page).to have_content search_job.title
      expect(page).to have_content search_job.city.name_and_state
      expect(page).to have_content search_job.description
    end
  end
end
