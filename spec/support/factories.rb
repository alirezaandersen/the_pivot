FactoryGirl.define do

  factory :users_jobs do
    job
    user
  end

#   factory :volunteer do
#     first_name "basic"
#     last_name "user"
#     sequence(:username) { |n| "#{n}_user" }
#     sequence(:email) { |n| "#{n}fake@gmail.fake" }
#     password "password"
#     password_confirmation "password"
#   end
#
  factory :job do
    sequence(:title) { |n| "Job #{n}" }

    sequence :description, ["A", "B", "C"].cycle do |n|
      "#{n} description"
    end

    sequence :years_of_experience, ["1", "2"].cycle do |n|
      "#{n}"
    end

    sequence :department, %w("Engineering", "Sales", "Customer Success").cycle do |n|
      "#{n}"
    end

    city
    status 0
    education "Bachelor"
    salary 75000
    job_type "Full-time"
    company
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
end
