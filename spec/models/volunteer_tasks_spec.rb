require 'rails_helper'

RSpec.describe Commitment, type: :model do
  context "cart checkout" do
    it "associates volunteer with task and updates pledge_date" do
      task_1, task_2 = create_list(:task, 2)
      volunteer = create(:volunteer)
      session = { task_1.id.to_s => 1, task_2.id.to_s => 1 }
      Commitment.associate_tasks(session, volunteer)

      updated_task_1, updated_task_2 = volunteer.tasks
      expect(updated_task_1.status).to eq("pledged")
      expect(updated_task_2.status).to eq("pledged")

      expect(updated_task_1.volunteer_id).to eq(volunteer.id)
      expect(updated_task_2.volunteer_id).to eq(volunteer.id)
    end
  end
end
