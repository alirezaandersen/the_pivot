class VolunteerTasks
  def self.associate_tasks(session, volunteer)
    session.each do |task_id, _v|
      Task.find(task_id).update_attributes(volunteer_id: volunteer.id)
    end
  end
end
