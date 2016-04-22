require 'rails_helper'

RSpec.feature "User can view retired items" do
  scenario "they can visit retired items page" do
    city = create(:city_with_tasks)
    task = city.tasks.last
    task.update_attributes(status: "retired")

    visit task_path(task)
    save_and_open_page

    expect(page).to have_content("Task Retired")
    expect(page).to_not have_content("Add to Cart")
  end
end

# As a user if I visit an item page and that item has been retired
#       Then I should still be able to access the item page
#       And I should not be able to add the item to their cart
#       And I should see in place of the "Add to Cart" button or link - "Item Retired"
