module UserHelpers

  def login_user(user)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button("LOGIN")
  end

  def users_job_with_resume(user, job)
    UsersJob.create(user_id: user.id, job_id: job.id, resume: "#{Rails.root}/spec/support/sample_cv_of_failures.pdf", status: 1)
  end
end
