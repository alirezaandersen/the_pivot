
1.upto(10) do |i|
  Task.create(name:        "Name #{i}",
              description: "Description #{i}",
              date:        Date.new,
              start_time:  Time.new,
              hours:       "#{i}",
              image_path:  "https://robohash.org/#{i}")
end
