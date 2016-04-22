require 'rails_helper'

RSpec.feature "User can view retired items" do
  skip
  scenario "they can visit retired items page" do
    task = create(:task)
    task.status = "retired"

    visit task_path(task)

    expect(page).to have_content("Item Retired")
    expect(page).to_not have_content("Add to Cart")
  end
end

# As a user if I visit an item page and that item has been retired
#       Then I should still be able to access the item page
#       And I should not be able to add the item to their cart
#       And I should see in place of the "Add to Cart" button or link - "Item Retired"
