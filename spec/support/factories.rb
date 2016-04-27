FactoryGirl.define do

  factory :commitment do
    task
    volunteer
  end

  factory :volunteer do
    first_name "basic"
    last_name "user"
    sequence(:username) { |n| "#{n}_user" }
    sequence(:email) { |n| "#{n}fake@gmail.fake" }
    password "password"
    password_confirmation "password"
  end

  factory :task do
    start_time "2016-04-18 18:58:35"
    date "11/12/2017"

    sequence(:name) { |n| "Task #{n}" }

    sequence :description, ["A", "B", "C"].cycle do |n|
      "#{n} description"
    end

    sequence :hours, ["1", "2"].cycle do |n|
      "#{n}"
    end

    zip_code "10204"

    sequence(:address) { |n| "#{n} Main Street" }

    city
  end

  factory :city do
    sequence :name, ["Denver", "Aurora", "Turingopolis"].cycle do |n|
      "#{n}"
    end

    sequence :state, ["CO", "NY", "CA"].cycle do |n|
      "#{n}"
    end

    factory :city_with_tasks do
      transient do
        tasks_count 4
      end

      after(:create) do |city, evaluator|
        create_list(:task, evaluator.tasks_count, city: city)
      end
    end
  end
end
