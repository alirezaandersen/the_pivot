class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def total
    contents.values.sum
  end

  def add_task(task_id)
    contents[task_id.to_s] ||= 0
    contents[task_id.to_s] += 1
  end

  def total_hours
    tasks = contents.map {|key, value| Task.find(key)}
    tasks.reduce(0) { |sum, task| sum += task.hours }
  end
end
