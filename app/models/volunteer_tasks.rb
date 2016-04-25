class VolunteerTasks

  def self.associate_tasks(session, volunteer)
    session.each do |task_id, _v|
      task = Task.find(task_id)
      task.update_attributes(volunteer_id: volunteer.id, pledge_date: Date.today)
      task.pledged!      
    end
  end
end
