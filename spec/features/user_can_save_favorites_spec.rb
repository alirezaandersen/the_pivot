require 'rails_helper'

RSpec.feature "Registered user can save favorites" do
  include UserHelpers

  scenario "they can save favorites" do
    user = create(:user)
    job = create(:job)

    visit job_path(job.title)

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

    # expect(page).to have_button("My Favorites")

    # click_on("Save your Favorites")
    # within(".dashboard") do
    #   click_on("My Favorites")
    # end
    expect(page).to have_current_path("/favorites")
    click_button("Save your Favorites")

    expect(page).to have_current_path(users_job_path(user))

    # within(".flash-notice") do
    #   expect(page).to have_content("Your Jobs are Saved!")
    # end

    within(".card-reveal") do
      expect(page).to have_content(job.title)
      # expect(page).to have_content("#{task_2.name}")
    end
    # expect(page).to have_content("Cart: 0")
  end

  # scenario "user gets redirected to city_path when adding item to cart" do
  #   city = create(:city_with_tasks)
  #
  #   visit city_path(city)
  #   page.all(".card-action")[0].click_link("Add to Cart")
  #
  #   expect(page).to have_current_path(city_path(city))
  # end
end
