city_one = City.create(name: "Denver",
                       state: "CO")

city_two = City.create(name: "Aurora",
                       state: "CO")

Volunteer.create(first_name: "basic",
                 last_name:  "user",
                 username:   "user",
                 password:   "password",
                 email:      "fake_account@gmail.com")

Volunteer.create(first_name: "super",
                 last_name:  "user",
                 username:   "admin",
                 password:   "password",
                 email:      "fake_account@yahoo.com",
                 role:       1)

1.upto(4) do |i|
  Task.create(name:        "Name #{i + 4}",
              description: "Description #{i}",
              date:        "11/04/2016",
              start_time:  Time.new,
              hours:       "#{i}",
              image_path:  "https://robohash.org/#{i}",
              city_id:     city_two.id)

  Task.create(name:        "Name #{i}",
              description: "Description #{i}",
              date:        "11/04/2016",
              start_time:  Time.new,
              hours:       "#{i}",
              image_path:  "https://robohash.org/#{i}",
              city_id:     city_one.id)
end
