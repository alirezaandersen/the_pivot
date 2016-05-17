require 'rails_helper'


RSpec.feature "Store Admin view all jobs for store" do
  scenario "Store Admin can see all jobs for its own store" do

    user = store_admin_user
    company = create(:company)
    jobs = []
    5.times { jobs << create(:job)}
    jobs.each{|j| j.update(company_id: 1)}

    visit login_path

    expect(page).to have_current_path login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "LOGIN"
    expect(page).to have_current_path store_admin_dashboard_path

    click_link "View Company Jobs"
    expect(page).to have_current_path store_jobs_path("#{company.id}")

    expect(page).to have_content("#{company.name}")
    expect(page).to have_content("#{jobs[0].title}")
    expect(page).to have_content("#{jobs[3].title}")


  end
end
