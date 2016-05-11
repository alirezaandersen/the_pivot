class Favorites
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  # def total
  #   contents.values.sum
  # end

  def add_job(job_id)
    contents[job_id.to_s] = 1
  end

  def remove_job(job_id)
    contents.delete(job_id.to_s)
  end

  # def total_hours
  #   tasks.reduce(0) { |sum, task| sum += task.hours }
  # end

  def has_job?(job_id)
    contents.has_key?(job_id.to_s)
  end

  def jobs
    self.contents.map { |job_id, _quantity| Job.find(job_id) }
  end
end
