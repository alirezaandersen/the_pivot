# Technical Expectations

You are to extend Little Shop so that it can handle multiple, simultaneous businesses. Each business should have:

A unique name: Ziba
A unique URL pattern (http://example.com/name-of-business)
Unique items: jobs
Unique orders: job applications
Unique administrators
The Pivot should be able to handle the following users:

### Guest Job Seeker

As a guest job seeker, I should be able to:

* Search for jobs through the landing page.
* Search for jobs through the navigation bar.
* Visit a company's webpage.
* Search for company-specific jobs within the company's profile page.
* Add jobs from multiple companies into a favorites 'folder'.
* Log in or create an account before completing saving or applying to jobs.

### Registered Job Seeker

As an registered job seeker, I should be able to:

* See my dashboard upon login.
  *  On my dashboard, I will see the following:
      - links to jobs I've applied for;
      - link to my current resume (if no resume, I can upload my resume);
      - links to favorited jobs that I want to apply for;
      - my profile (first name, last name, email) and a link to edit my profile.
* I am able to see a more detailed list of jobs I've applied for (job applications history).
* I am able to see a more detailed list of jobs I've favorited (favorites folder/list).
* Apply to jobs and save favorite jobs
  - jobs that have been applied to will no longer be favorited
* When I click on a button to apply to a job, I will be prompt to upload a resume and/or complete a cover letter in the form.
* Work on one job application at a time
* Submit to a job for a company only once, so I cannot apply to the same job twice.

### Business Admin

As a business admin, I should be able to:

* Manage listing of job opportunities for my company.
* Create job listings for my company with the following requirements (new):
  - department/division;
  - job description;
  - job location;
  - status (full-time, part-time, hourly, salary);
  - pay range;
  - job requirements (years of experience, education, certifications);
  - job title;
  - redirects to all jobs view
* View all applicants to jobs at my company.
  - view name - link to applicants show page that shows all jobs they applied for

* View all the jobs at my company.
 - update/delete each job
 - link to company-job show - which shows all applicants for this job(with link to each applicants name, contact and resume)
 - link to create new job

* Update my company profile (website/URL, about us, company size, company industry, company logo image)

* applicants show page:
 - name
 - list of all jobs in company they applied to

* Manage other business admins for my company
* View my dashboard, which includes:
  - name;
  - company name and logo;
  - company info
  - update company info
  - 'Create job' link;
  - View applicants
  - View all jobs

### Ziba Admin

As a Ziba admin, I should be able to:

* Approve or decline the creation of new companies
* Take a company offline / online
* Perform any functionality restricted to business admins

 Ziba Admin dashboard
 - profile
 - pending companies - buttons: approve/deny
 - link to company show page with status (approved/denied)

 need 4 roles (default: job seeker; basic company admin; head company admin; Ziba admin)
