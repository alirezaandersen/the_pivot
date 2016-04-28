city_one = City.create(name: "Denver",
                       state: "CO",
                       image_path: "http://www.justrenttoown.com/blog/wp-content/uploads/2015/04/denvercity.jpg")

city_two = City.create(name: "Aurora",
                       state: "CO",
                       image_path: "https://s3.amazonaws.com/external_clips/attachments/30218/original/aurora.jpg?1414099418")

city_three = City.create(name: "Boulder",
                        state: "CO",
                        image_path: "http://workbright.com/wp-content/uploads/2015/11/Boulder.jpg")
city_four = City.create(name: "Golden",
                        state: "CO",
                        image_path: "https://s3.amazonaws.com/gs-waymarking-images/048c46ec-cf99-4355-badd-476d34f246c3.JPG")

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
    2016, 12, 15, "3:00 PM", 4, "garden.jpg", city_one.id,
    "1502 Blake St", "80202"],
  ["Restock the Library",
    "The order of new books is in. Come and help us restock our shelves. No previous experience necessary.",
    2016, 05, 15, "10:00 AM", 5, "library.jpg", city_one.id,
    "10 W 14th Ave Pkwy", "80204"],
  ["Dog Walking",
    "Join our team of dog lovers and take a stroll with one of our lucky dogs at dog-day care. Dogowners preferred, familiarity with dogs necessary.",
    2016, 06, 03, "2:30 PM", 2, "dogs.jpg", city_two.id,
    "2170 Airport Blvd", "80011"],
  ["Feed the Hungry",
    "Help the community kitchen by preparing soup this sunday. We need several people for food prep. We also need several people to serve the soup. If you can come, please come! We hope to see you next sunday.",
    2016, 04, 05, "8:00 AM", 3, "feed.jpg", city_one.id,
    "1600 17th St", "80202"],
  ["Clean the Beach",
    "Come to the famous Arvada coast to help pick up trash and things. There are many things on this beach, so we better clean it up. There’s a lot of stuff out there. We’re gonna go out, pick it up, get it off the beach and enjoy the beach.",
    2017, 05, 30, "4:00 PM", 6,  "beach.jpg", city_two.id,
    "170 S Chambers Rd", "80017"],
  ["Paint Saint Matthews",
    "Greetings! our church needs painted. Do you want to come help paint this church? We’ve got the supplies. All you need to do is show up! We have a lot of stuff to do like take care of things, and cut the wood, and paint the church, and feed the hungry after we paint the church. come on by!",
    2016, 04, 30, "1:00 PM", 7, "paint.jpg", city_two.id,
    "170 S Chambers Rd", "80017"],
  ["Pick up on Main Street",
    "We are going to pick up a lot of stuff on main street. Main street used to be beautiful and now it is not. Make main street beautiful again! We have lots of people that are going to come pick up main street and it is going to be great! come out friday!",
    2016, 06, 24, "1:00 AM", 12, "mainst.jpg", city_one.id,
    "100 W 14th Ave Pkwy", "80204"],
  ["Clean the Platte",
    "The Platte is a very dirty river. It’s a smelly place, with lots of stinky stuff. Lets change that! We can go in there, and get all the smelly stuff out of there. When do you want to do it? We will do it all the time, if we could. but we can’t, so we are going to meet next sunday.",
    2016, 04, 11, "3:00 PM", 3, "platte.jpg", city_one.id,
    "2000 Elitch Cir", "80204"],
  ["Teach Shoe Tying",
    "We have a lot of kids. They need to have their shoes tied, and we cannot tie their shows for them all the time, every day, all the time, every day - we are tired of doing that. We are looking for a professonal shoe tyer to come in and do things with them like teach them how to tie their shoes. That will be great. Then we will have a lot of time for other activities, other than shoe tying.",
    2017, 01, 01, "3:00 PM", 2, "shoes.jpg", city_two.id,
    "50 S Peoria St", "80012"],
  ["Bake Cookies",
    "Support our community event on Saturday with one tray of homemade sweet treasures. Please also provide the ingredients for people with food allergies.",
    2016, 11, 10, "11:00 AM", 3, "cookies.jpg", city_one.id,
    "1101 S Washington St", "80210"],
  ["Enchanted Forrest", "Dress up in a fairytale costume and give out treats to children on their hike through the enchanted prairie. Bring your own non-scary costume if you have one.",
    2016, 11, 30, "2:30 PM", 5, "halloween.jpg", city_one.id,
    "1101 S Washington St", "80013"],
  ["Climbing for Humanity",
    "Apply your physical prowess for humanity. Every person cannot be their best at all times. This means trash may be left behind, tucked away where Mother Nature stores her secrets. Spend a few hours cleaning up the foothills while getting a great work out and being one with Mother Earth. Sounds rejunvating.",
    2016, 12, 15, "3:00 PM", 4, "climber.jpeg", city_three.id,
    "1165 13th St", "80302"],
  ["Cat Sitting",
    "You don't have your own cat but you love spending time with these furry creatures. We are looking for a loving cat-sitter who has special cat whispering abilities. Got a few hours? Wonderful.",
    2016, 07, 15, "12:00 PM", 4, "lola.jpg", city_three.id,
    "1447 Pearl St.", "80302"]
  ]

created_tasks = tasks.map do |task|
  Task.create(
    name: task[0],
    description: task[1],
    date: Date.new(task[2], task[3], task[4]),
    start_time: task[5],
    hours: task[6],
    image: File.open("#{Rails.root}/app/assets/images/#{task[7]}"),
    city_id: task[8],
    address: task[9],
    zip_code: task[10])
  end

created_tasks.last.retired!
