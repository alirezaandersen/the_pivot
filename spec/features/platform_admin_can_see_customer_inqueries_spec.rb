require 'rails_helper'


RSpec.feature "Platform Admin can view customer inquiries" do
  scenario "Platform Admin can log in and see their dashboard" do

    user = platform_admin_user
    customers = []
    5.times {customers << create(:contact_us)}

    visit login_path

    expect(page).to have_current_path login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "LOGIN"

    expect(page).to have_current_path platform_admin_dashboard_path

    expect(page).to have_content("Welcome Super #{user.first_name}")
    expect(page).to have_content("Email: #{user.email}")

    click_link("Customer Inquiries")

    expect(page).to have_current_path customer_inquiries_path
    save_and_open_page
    expect(page).to have_content("Total Inquiries")
    expect(page).to have_content("#{customers[0].description}")
    expect(page).to have_content("#{customers[1].description}")
    expect(page).to have_content("#{customers[2].description}")
    expect(page).to have_content("#{customers[3].description}")
    expect(page).to have_content("#{customers[4].description}")
  end
end
