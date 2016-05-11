require 'rails_helper'

RSpec.feature "Visitor can favorite jobs" do
  scenario "they visit jobs show page and favorite a job" do
    job = create(:jobs, 1)
    visit job_path(job.id)
    expect(page).to have_content("Favorite")
    first(".card-action").click_link("Favorite")

    expect(page).to have_content("Job favorited!")
    # expect(page).to have_content("Cart: 1")
  end

  scenario "they can view contents of favorites" do
    job = create(:jobs, 2)

    visit job_path(job.id)

    first(".card-action").click_link("Favorite")

    within("nav") do
      click_link("Favorites")
    end

    expect(page).to have_current_path("/favorites")
    expect(page).to have_content job.name
    expect(page).to have_content job.description
    expect(page).to have_content job.location
  end

  # scenario "they can see total hours of tasks" do
  #   create(:city_with_tasks)
  #
  #   visit tasks_path
  #
  #   first(".card-action").click_link("Add to Cart")
  #   page.all(".card-action")[1].click_link("Add to Cart")
  #
  #   within(".main-resources") do
  #     click_link("Cart:")
  #   end
  #   expect(page).to have_content("Total Hours: 3")
  # end

  scenario "they cannot favorite the same job twice" do
    job1, job2 = create(:jobs, 2)

    visit job_path(job1.id)
    first(".card-action").click_link("Favorite")
    visit job_path(job2.id)
    first(".card-action").click_link("Favorite")

    # expect(page).to have_content("Favorites: 2")

    visit job_path(job1.id)
    first(".card-action").click_link("Favorite")

    # expect(page).to have_content("Favorite: 2")
    expect(page).to have_content("Job is already in your Favorites!")
  end

  scenario "they can remove a job from favorites" do
    job1, job2 = create(:jobs, 2)

    message = "Job #{job1.name} removed from your favorites."

    visit job_path(job1.id)
    first(".card-action").click_link("Favorite")
    visit job_path(job2.id)
    first(".card-action").click_link("Favorite")

    within('nav') do
      click_on("Favorites")
    end

    expect(page).to have_current_path(favorites_path)
    expect(page).to have_content("job1.name")
    expect(page).to have_content("job2.name")
    first(".card-action").click_link("Unfavorite")

    # expect(page).to have_content("Total Hours: 1")

    within(".card-content") do
      expect(page).not_to have_content("#{job1.name}")
    end

    within(".flash-notice") do
      expect(page).to have_content(message)

      expect(page).to have_link("#{job2.name}")
    end

    click_link("#{job2.name}")
    expect(page).to have_current_path(job_path(job2.id))
  end
end
