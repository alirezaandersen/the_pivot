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
end
