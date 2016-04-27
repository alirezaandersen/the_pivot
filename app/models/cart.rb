class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def total
    contents.values.sum
  end

  def add_task(task_id)
    contents[task_id.to_s] = 1
  end

  def remove_task(task_id)
    contents.delete(task_id.to_s)
  end

  def total_hours
    tasks.reduce(0) { |sum, task| sum += task.hours }
  end

  def has_task?(task_id)
    contents.has_key?(task_id.to_s)
  end

  def tasks
    self.contents.map { |task_id, _quantity| Task.find(task_id) }
  end

end
