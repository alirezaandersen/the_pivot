require 'rails_helper'

RSpec.feature "Visitor can view landing page" do
  scenario "they can navigate to the tasks index" do
    cities = create_list(:city_with_tasks, 4)

    visit root_path

    expect(page).to have_button "View All Tasks"
    cities.each do |city|
      expect(page).to have_content city.name
    end

    click_button "View All Tasks"

    expect(page).to have_current_path tasks_path
    cities.each do |city|
      city.tasks.each do |task|
        expect(page).to have_content task.name
        expect(page).to have_content task.description
        expect(page).to have_content task.hours
        expect(page).to have_css "img[src*='#{task.image_path}']"
      end
    end
  end

  scenario "the see photo carousel on landing" do
    visit root_path

    within(".slides") do
      expect(page).to have_xpath "//img[@src=\'https://images.unsplash.com/photo-1417037129170-06a2750eaa47?crop=entropy&fit=crop&fm=jpg&h=1000&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=1925\']"
      expect(page).to have_xpath "//img[@src=\'https://images.unsplash.com/photo-1429043794791-eb8f26f44081?crop=entropy&fit=crop&fm=jpg&h=1000&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=1925\']"
    end
  end
end
