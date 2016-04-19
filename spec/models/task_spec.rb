require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'associations' do
    it { should belong_to(:volunteer) }
    it { should belong_to(:city) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:hours) }
    it { is_expected.to validate_presence_of(:image_path) }
    it { is_expected.to validate_presence_of(:city_id) }
    # it { is_expected.to validate_format_of(:date) }
  end

  # context "date/time" do
  #   Task.create( name: "name",
  #             description: "description",
  #             date: "11/22/2024",
  #             start_time: "3:00 PM",
  #             image_path: "https://robohash.org/1",
  #             city_id: 2
  #
  #   )
  #
  #   # task = Task.all.first
  #   expect(task.formatted_start_time).to eql "3:00 PM"
  # end
end
