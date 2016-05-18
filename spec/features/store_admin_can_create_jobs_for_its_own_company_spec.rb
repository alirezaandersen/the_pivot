require 'rails_helper'


RSpec.feature "Store Admin can create jobs for its own company" do
  scenario " Store Admin can create jobs for its company" do

    user = store_admin_user
    company = create(:company)

    visit login_path

    expect(page).to have_current_path login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "LOGIN"
    expect(page).to have_current_path store_admin_dashboard_path

    click_link "Create Job"

    expect(page).to have_current_path create_company_jobs_path(user.company_id)

    fill_in "Position Title", with: "Teacher"
    fill_in "Department", with: "Education"
    fill_in "Requirements", with: "Smiles"
    fill_in "Job Type", with: "Full Time"
    fill_in "Salary", with: "1000"
    fill_in "Description of Job", with: "Programmer"

    click_on "Create A Job"
    job = Job.find_by(company_id: company.id, title: "Teacher")
    expect(page).to have_current_path company_job_path(company, job)
    expect(page).to have_content("#{company.name}")
  end
end
