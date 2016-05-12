require 'rails_helper'

RSpec.feature "Visitor can view landing page" do
  scenario "they can view the navbar" do
    visit root_path

    within("nav") do
      expect(page).to have_content "JOBS"
      expect(page).to have_content "COMPANIES"
      expect(page).to have_content "ZIBA"
      expect(page).to have_content "LOGIN/REGISTER"
      expect(page).to have_content "FAVORITES"
    end
  end

  scenario "they can view the slider" do
    visit root_path

    within(".first-slide") do
      expect(page).to have_content "Jobs available now!"
    end

    within(".slides") do
      expect(page).to have_xpath "//img[@src=\'https://images.unsplash.com/photo-1417037129170-06a2750eaa47?crop=entropy&fit=crop&fm=jpg&h=1000&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=1925\']"
      expect(page).to have_xpath "//img[@src=\'https://images.unsplash.com/photo-1429043794791-eb8f26f44081?crop=entropy&fit=crop&fm=jpg&h=1000&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=1925\']"
    end
  end

  scenario "they can view a footer" do
    visit root_path

    within("footer") do
      expect(page).to have_content "About Us"
      expect(page).to have_content "Contact"
    end
  end
end
