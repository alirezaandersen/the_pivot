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
      expect(page).to have_xpath "//img[@src=\'http://www.newyorker.com/wp-content/uploads/2014/08/Stokes-Hello-Kitty2-1200.jpg\']"
      expect(page).to have_xpath "//img[@src=\'https://static.pexels.com/photos/7096/people-woman-coffee-meeting.jpg\']"
    end
  end
end
