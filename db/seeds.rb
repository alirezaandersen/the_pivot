city_one = City.create(name: "Denver",
                       state: "CO")

city_two = City.create(name: "Aurora",
                       state: "CO")


1.upto(5) do |i|
  Task.create(name:        "Name #{i}",
              description: "Description #{i}",
              date:        Date.new,
              start_time:  Time.new,
              hours:       "#{i}",
              image_path:  "https://robohash.org/#{i}",
              city_id:     city_one.id)
end

6.upto(10) do |i|
  Task.create(name:        "Name #{i}",
              description: "Description #{i}",
              date:        Date.new,
              start_time:  Time.new,
              hours:       "#{i}",
              image_path:  "https://robohash.org/#{i}",
              city_id:     city_two.id)
end
