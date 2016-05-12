FactoryGirl.define do
  factory :user do
    first_name
    last_name
    email
    password "password"
    role
  end

  sequence :first_name do |fn|
    "#{fn}"
  end

  sequence :last_name do |ln|
    "#{ln}"
  end

  sequence :email do |e|
    "#{e}@gmail.com"
  end

  sequence :role do |r|
    r = 0
  end

  factory :users_job do
    status "MyString"
    resume "MyText"
    user
    job
  end

  factory :job do
    title
    description
    years_of_experience
    department
    city
    status 0
    education "Bachelor"
    salary 75000
    job_type "Full-time"
    company
  end

  sequence(:title) { |n| "Job #{n}" }

  sequence :description, ["A", "B", "C"].cycle do |n|
    "#{n} description"
  end

  sequence :years_of_experience, ["1", "2", "10"].cycle do |n|
    "#{n}"
  end

  sequence :department, %w("Engineering", "Sales", "Customer Success").cycle do |n|
    "#{n}"
  end



  factory :city do
    sequence :name, %w(Denver Aurora Turingopolis).cycle do |n|
      "#{n}"
    end

    sequence :state, ["CO", "NY", "CA"].cycle do |n|
      "#{n}"
    end

    factory :city_with_jobs do
      transient do
        jobs_count 4
      end

      after(:create) do |city, evaluator|
        create_list(:job, evaluator.jobs_count, city: city)
      end
    end
  end

  factory :company do
    name "NIKE"
    description "Making the flyest shoes that sneaker heads get hyped about."
    logo "http://static.businessinsider.com/image/53d29d5c6bb3f7a80617ada8/image.jpg"
    url "http://www.nike.com/us/en_us/"
    size 1
    industry "Footwear"
  end
end
