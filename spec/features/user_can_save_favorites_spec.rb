require 'rails_helper'

RSpec.feature "Registered user can save favorites" do
  include UserHelpers

  scenario "they can save favorites" do
    user = create(:user)
    job = create(:job)

    visit company_job_path(job.company, job)

    within("#job-text-box") do
      click_link("FAVORITE")
    end

    within(".main-resources") do
      click_on("FAVORITES")
    end

    expect(page).to have_current_path("/favorites")
    expect(page).to_not contain_exactly("Save your Favorites")
    click_button("Login to save your Favorites")

    login_user(user)

    within(".main-resources") do
      expect(page).to have_content("LOGOUT")
    end

    expect(page).to have_current_path("/dashboard")

    within(".main-resources") do
      click_on("FAVORITES")
    end

    expect(page).to have_current_path("/favorites")
    click_button("Save your Favorites")

    expect(page).to have_current_path(my_favorites_path(user))

    within(".card-reveal") do
      expect(page).to have_content(job.title)
    end
  end
end
