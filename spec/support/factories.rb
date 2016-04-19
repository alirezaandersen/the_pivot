FactoryGirl.define do

  factory :task do
    sequence(:name) { |n| "Task #{n}" }
    description
    date "2016-04-18"
    start_time "2016-04-18 18:58:35"
    hours
    volunteer nil
    sequence(:image_path) { |n| "https://robohash.org/#{n}" }
    city
  end

  factory :city do
    name
    state

    factory :city_with_tasks do
      transient do
        tasks_count 5
      end

      after(:create) do |city, evaluator|
        create_list(:task, evaluator.tasks_count, city: city)
      end
    end
  end

  sequence :name, ["denver", "aurora", "turingopolis"].cycle do |n|
    "#{n}"
  end

  sequence :state, ["CO", "NY", "CA"].cycle do |n|
    "#{n}"
  end

  sequence :hours, ["1", "2", "3"].cycle do |n|
    "#{n}"
  end

  sequence :description, ["A", "B", "C"].cycle do |n|
    "#{n} description"
  end

end
