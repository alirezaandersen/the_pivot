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



tasks = [
  ["Build a Community Garden",
  "Weeding, prepare soil, plant seedlings. Get together with your community. Make great things happen. No previous experience needed.",
  2016, 12, 15, "3:00 PM", 4, "https://robohash.org/llt", city_two.id,
  "1502 Blake St. Denver, CO 80202"],
  ["Restock the Library",
  "The order of new books is in. Come and help us restock our shelves. No previous experience necessary.",
  2016, 05, 15, "10:00 AM", 5, "https://robohash.org/nt", city_one.id,
  "10 W 14th Ave Pkwy, Denver, CO 80204"],
  ["Dog Walking",
  "Join our team of dog lovers and take a stroll with one of our lucky dogs at dog-day care. Dogowners preferred, familiarity with dogs necessary.",
  2016, 06, 03, "2:30 PM", 2, "https://robohash.org/tt", city_two.id,
  "2170 Airport Blvd, Aurora, CO 80011"],
  ["Feed the Hungry",
  "Help the community kitchen by preparing soup this sunday. We need several people for food prep. We also need several people to serve the soup. If you can come, please come! We hope to see you next sunday.",
  2016, 04, 05, "8:00 AM", 3, "https://robohash.org/ghdjs", city_two.id,
  "1600 17th St, Denver, CO 80202"],
  ["Clean the Beach",
  "Come to the famous Arvada coast to help pick up trash and things. There are many things on this beach, so we better clean it up. There’s a lot of stuff out there. We’re gonna go out, pick it up, get it off the beach and enjoy the beach.",
  2017, 05, 30, "4:00 PM", 6,  "https://robohash.org/fhdkdjs", city_one.id,
  "170 S Chambers Rd, Aurora, CO 80017"],
  ["Paint Saint Matthews",
  "Greetings! our church needs painted. Do you want to come help paint this church? We’ve got the supplies. All you need to do is show up! We have a lot of stuff to do like take care of things, and cut the wood, and paint the church, and feed the hungry after we paint the church. come on by!",
  2016, 04, 30, "1:00 PM", 7, "https://robohash.org/fhd", city_one.id,
  "170 S Chambers Rd, Aurora, CO 80017"],
  ["Pick up on Main Street",
  "We are going to pick up a lot of stuff on main street. Main street used to be beautiful and now it is not. Make main street beautiful again! We have lots of people that are going to come pick up main street and it is going to be great! come out friday!",
  2016, 06, 24, "1:00 AM", 12, "https://robohash.org/fhjgjgj", city_two.id,
  "100 W 14th Ave Pkwy, Denver, CO 80204"],
  ["Clean the Platte",
  "The platte is a very dirty river. It’s a smelly place, with lots of stinky stuff. Lets change that! We can go in there, and get all the smelly stuff out of there. When do you want to do it? We will do it all the time, if we could. but we can’t, so we are going to meet next sunday.",
  2016, 04, 11, "3:00 PM", 3, "https://robohash.org/fhjgjjdkls", city_two.id,
  "2000 Elitch Cir, Denver, CO 80204"],
  ["Teach Shoe Tying",
  "We have a lot of kids. They need to have their shoes tied, and we cannot tie their shows for them all the time, every day, all the time, every day - we are tired of doing that. We are looking for a professonal shoe tyer to come in and do things with them like teach them how to tie their shoes. That will be great. Then we will have a lot of time for other activities, other than shoe tying.",
  2017, 01, 01, "3:00 PM", 2, "https://robohash.org/fhjgj", city_one.id,
  "50 S Peoria St, Aurora, CO 80012"]
  ]

tasks.each do |task|
  Task.create(name: task[0],
      description: task[1],
      date: Date.new(task[2], task[3], task[4]),
      start_time: task[5],
      hours: task[6],
      image_path: task[7],
      city_id: task[8])
end
