city_one = City.create(name: "Denver",
                       state: "CO")

city_two = City.create(name: "Aurora",
                       state: "CO")


1.upto(4) do |i|
  Task.create(name:        "Name #{i}",
              description: "Description #{i}",
              date:        "11/04/2016",
              start_time:  Time.new,
              hours:       "#{i}",
              image_path:  "https://robohash.org/#{i}",
              city_id:     city_one.id)
end

5.upto(9) do |i|
  Task.create(name:        "Name #{i}",
              description: "Description #{i}",
              date:        "01/23/2017",
              start_time:  Time.new,
              hours:       "#{i}",
              image_path:  "https://robohash.org/#{i}",
              city_id:     city_two.id)
end
