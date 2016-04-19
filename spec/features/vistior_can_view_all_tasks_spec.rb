require 'rails_helper'

RSpec.feature "Visitor can view all tasks" do

  # def gen_tasks
  #   city = City.create(name: "Denver",
  #                      state: "CO")
  #
  #   1.upto(3) do |i|
  #     Task.create(name:        "Name #{i}",
  #                 description: "Description #{i}",
  #                 date:        Date.new,
  #                 start_time:  Time.new,
  #                 hours:       "#{i}",
  #                 image_path:  "https://robohash.org/#{i}",
  #                 city_id:     city.id)
  #   end
  # end


  scenario "they see the names of all tasks" do
    create(:city_with_tasks)
    tasks = Task.take(3)

    # gen_tasks
    # tasks = Task.take(3)

    visit tasks_path

    expect(page).to have_content tasks[0].name
    expect(page).to have_content tasks[0].description
    expect(page).to have_content tasks[0].hours
    expect(page).to have_css("img[src*='#{tasks[0].image_path}']")

    expect(page).to have_content tasks[1].name
    expect(page).to have_content tasks[1].description
    expect(page).to have_content tasks[1].hours
    expect(page).to have_css("img[src*='#{tasks[1].image_path}']")

    expect(page).to have_content tasks[2].name
    expect(page).to have_content tasks[2].description
    expect(page).to have_content tasks[2].hours
    expect(page).to have_css("img[src*='#{tasks[2].image_path}']")
  end

  scenario "they see tasks by city" do
    city_one = create(:city_with_tasks)
    city_two = create(:city_with_tasks)

    tasks = Task.take(2)

    visit "/#{city_one.name}"

    expect(page).to have_content tasks[0].name
    expect(page).to have_content tasks[0].description
    expect(page).to have_content tasks[0].hours
    expect(page).to have_css("img[src*='#{tasks[0].image_path}']")

    expect(page).to have_content tasks[1].name
    expect(page).to have_content tasks[1].description
    expect(page).to have_content tasks[1].hours
    expect(page).to have_css("img[src*='#{tasks[1].image_path}']")
  end
end
