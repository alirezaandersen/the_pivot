class Commitment < ActiveRecord::Base
  belongs_to :volunteer
  belongs_to :task

  def self.associate_tasks(cart, volunteer)
    cart.each do |task_id, _v|
      task = Task.find(task_id)
      task.update(pledge_date: Date.today)
      volunteer.commitments.create(task_id: task.id)
      task.pledged!
    end
  end
end
