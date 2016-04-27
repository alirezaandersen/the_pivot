require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'associations' do
    it { should have_many(:commitments) }
    it { should have_many(:volunteers).through(:commitments) }
    it { should belong_to(:city) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:hours) }
    it { is_expected.to validate_presence_of(:city_id) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:zip_code) }
  end

  context "status helper methods" do
    it "shows status pledged" do
      task_one, task_two, task_three = create_list(:task, 3)
      task_two.pledged!

      expect(Task.pledged).to include(task_two)
    end

    it "shows status pending" do
      task_one, task_two, task_three = create_list(:task, 3)
      task_three.pending!

      expect(Task.pending).to include(task_three)
    end

    it "shows status completed" do
      task_one, task_two, task_three = create_list(:task, 3)
      task_one.completed!

      expect(Task.completed).to include(task_one)
    end


  end

  context 'format address' do
    it 'formats address' do
    city = create(:city_with_tasks)
    task =  Task.create(name:  "Name",
                        description: "Description",
                        date:        "11/04/2016",
                        start_time:  "3:00 PM",
                        hours:       3,
                        city_id:     city.id,
                        address:     "942 Hazel Court",
                        zip_code:    "80204")

    expect(task.format_address).to eql("942+Hazel+Court+Denver+CO+80204")
    end
  end
end
