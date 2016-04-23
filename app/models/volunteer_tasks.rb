class VolunteerTasks
  def self.associate_tasks(session, volunteer)
    session.each do |k, v|
      Task.find(k).update_attributes(volunteer_id: volunteer.id)
    end
  end
end
