require 'rails_helper'

RSpec.feature "Visitor can favorite jobs" do
  scenario "they visit jobs show page and favorite a job" do

    job = create(:job)

    visit job_path(job.title)
    expect(page).to have_content("FAVORITE")
    first("#job-text-box").click_link("FAVORITE")

    expect(page).to have_content("Job favorited!")
  end

  scenario "they can view contents of favorites" do
    job = create(:job)

    visit job_path(job.title)

    first("#job-text-box").click_link("FAVORITE")

    within(".main-resources") do
      click_link("FAVORITES")
    end

    expect(page).to have_current_path("/favorites")
    expect(page).to have_content job.title
    expect(page).to have_content job.description
    expect(page).to have_content job.city.name
    expect(page).to have_button("Save your Favorites")
  end

  scenario "they can remove a job from favorites" do
    job1, job2 = create_list(:job, 2)

    visit job_path(job1.title)
    first("#job-text-box").click_link("FAVORITE")
    visit job_path(job2.title)
    first("#job-text-box").click_link("FAVORITE")

    within('.main-resources') do
      click_on("FAVORITES")
    end
    expect(page).to have_current_path(favorites_path)
    expect(page).to have_content(job1.title)
    expect(page).to have_content(job2.title)
    visit job_path(job1.title)
    first("#job-text-box").click_link("UNFAVORITE")

    within('.main-resources') do
      click_on("FAVORITES")
    end

    within(".card-content") do
      expect(page).not_to have_content(job1.title)
    end

    expect(page).to have_link("#{job2.title}")
    click_link("#{job2.title}")
    expect(page).to have_current_path(job_path(job2.title))
  end
end
