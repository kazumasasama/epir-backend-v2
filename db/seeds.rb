# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

categories = [
  "SS Parts",
  "S Parts",
  "M Parts",
  "L Parts",
  "Discounted Package",
  "First Time Trial",
  "Facial"
]

categories.each do |category|
  Category.create!(
    title: category
  )
end

menus = [
  {
    title: "First Time Diagnostics",
    duration: 30,
    price: 0,
    description: "First time diagnostics",
    category_id: 6
  },
  {
    title: "Armpits",
    duration: 30,
    price: 22,
    description: "Both armpits",
    category_id: 1
  },
  {
    title: "Face",
    duration: 60,
    price: 150,
    description: "Full face",
    category_id: 7
  },
  {
    title: "Arms (Below the elbow)",
    duration: 60,
    price: 55,
    description: "Both arms (Below the elbow)",
    category_id: 3
  },
  {
    title: "Legs",
    duration: 90,
    price: 200,
    description: "Both legs",
    category_id: 4
  },
  {
    title: "Test Inactive Menu",
    duration: 90,
    price: 999,
    description: "Test Inactidve Menu",
    active: false
  },
  {
    title: "Elbows",
    duration: 30,
    price: 22,
    description: "Both elbows",
    category_id: 1
  },
  {
    title: "Knees",
    duration: 30,
    price: 22,
    description: "Both knees",
    category_id: 1
  },
  {
    title: "Nipples",
    duration: 30,
    price: 22,
    description: "Both nipples",
    category_id: 1
  },
  {
    title: "Hands (Fingers and Back of Hand)",
    duration: 30,
    price: 22,
    description: "Back of both hands and fingers",
    category_id: 1
  },
  {
    title: "Feet",
    duration: 30,
    price: 22,
    description: "Both feet",
    category_id: 1
  },
  {
    title: "V Line",
    duration: 30,
    price: 33,
    description: "V Line",
    category_id: 2
  },
  {
    title: "O Line",
    duration: 30,
    price: 33,
    description: "O Line",
    category_id: 2
  },
  {
    title: "Nape",
    duration: 30,
    price: 33,
    description: "The nape of the neck",
    category_id: 2
  },
  {
    title: "Upper-Lip",
    duration: 30,
    price: 33,
    description: "Upper-Lip",
    category_id: 2
  },
  {
    title: "Shins",
    duration: 60,
    price: 55,
    description: "Both shins",
    category_id: 3
  },
  {
    title: "I Line",
    duration: 60,
    price: 55,
    description: "I line",
    category_id: 3
  },
  {
    title: "Breast",
    duration: 60,
    price: 55,
    description: "Breast",
    category_id: 3
  },
  {
    title: "Back (Upper)",
    duration: 60,
    price: 55,
    description: "Upper back",
    category_id: 3
  },
  {
    title: "Back (Whole)",
    duration: 90,
    price: 88,
    description: "Whole back",
    category_id: 4
  },
  {
    title: "Arms (Above the elbow)",
    duration: 90,
    price: 88,
    description: "Both arms (Above the elbow)",
    category_id: 4
  },
  {
    title: "Buttock",
    duration: 90,
    price: 88,
    description: "Buttock",
    category_id: 4
  },
  {
    title: "VIO Lines",
    duration: 120,
    price: 108,
    description: "VIO Lines",
    category_id: 5
  },
  {
    title: "Whole Body",
    duration: 240,
    price: 480,
    description: "Whole body",
    category_id: 5
  },
  {
    title: "Facial (Women)",
    duration: 90,
    price: 87,
    description: "Women's facial",
    category_id: 5
  },
  {
    title: "Facial (Men)",
    duration: 90,
    price: 87,
    description: "Men's facial",
    category_id: 5
  },
  {
    title: "Facial (Experimental)",
    duration: 90,
    price: 50,
    description: "Facial for both men and women. First time only experimental.",
    category_id: 5
  },
  {
    title: "VIO (Experimental)",
    duration: 90,
    price: 49,
    description: "VIO Lines. First time only experimental.",
    category_id: 5
  },
  {
    title: "Armpits (Experimental)",
    duration: 30,
    price: 5,
    description: "Both armpits. First time only experimental.",
    category_id: 5
  }
]

menus.each do |menu|
  Menu.create!(menu)
end

statuses = [
  'Medicine',
  'Reffered',
  'Sensitive for Pain'
]

i = 0
statuses.length.times do
  Status.create!(
    title: statuses[i]
  )
  i += 1
end

require 'faker'

business = Business.create!(
  name: 'Biznesu',
  email: 'biznesu@biznesu.com',
  phone: '111-111-1111',
  state: 'NY',
  city: 'New York',
  address: '111 W 111th Street',
  zip: '10011',
  url: 'https://biznesu.netlify.app/',
  insta: 'biznesuInsta',
  twitter: 'biznesuTwitter',
  facebook: 'biznesuFB'
)

config = Config.create!(
  lang: 'en',
  tax: 4.5,
  start: 10,
  end: 20,
  interval: 30
)

User.create!(
  first_name: "Master",
  last_name: "Admin",
  password: "password",
  email: "test@test.com",
  phone: "123-456-7890",
  gender: "N/A",
  zip: 10001,
  state: "NY",
  city: "New York",
  address: "545 W 30th St",
  note: "This is a note for Master Admin",
  birthday: "1900-01-01",
  status: "System",
  admin: true
)

User.create!(
  first_name: "Interval",
  password: "password",
  email: "interval@test.com",
  status: "System",
)

User.create!(
  first_name: "User",
  last_name: "1",
  password: "password",
  email: "user@user.com",
  phone: "098-765-4321",
  gender: "N/A",
  zip: 10001,
  state: "NY",
  city: "New York",
  address: "545 W 31th St",
  note: "This is a note for User1",
  birthday: "1900-01-01",
  status: "System",
  admin: false
)

birthday = Time.zone.parse('1950-01-01') 

user_count = 1
statuses_id = [*(1..(statuses.length))]
100.times do
  if user_count % 7 == 0
    user_note = Faker::JapaneseMedia::Doraemon.gadget
  else
    user_note = nil
  end

  user = User.new(
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.last_name,
    password: "password",
    email: "user#{user_count}@user.com",
    phone: Faker::PhoneNumber.cell_phone,
    gender: Faker::Gender.binary_type,
    zip: Faker::Address.zip,
    state: Faker::Address.state_abbr,
    city: Faker::Address.city,
    address: Faker::Address.street_address,
    note: user_note,
    birthday: birthday,
    status: "User",
    admin: false
  )
  user.save
  if user_count % 5 == 0
    UserStatus.create!(
      user_id: user.id,
      status_id: statuses_id.sample
    )
  end
  birthday += 40.days
  user_count += 1
end

date = Date.current

90.times do
  start_time = Time.zone.parse("10:00:00")
  20.times do
    BusinessTime.create!(
      date: date,
      time: start_time,
      available: true
    )
    start_time += 1800.seconds # 30 min
  end
  date += 1
end

user_id = 4
start_time = [
  Time.zone.parse("10:00:00"),
  Time.zone.parse("12:00:00"),
  Time.zone.parse("14:00:00"),
  Time.zone.parse("16:00:00"),
  Time.zone.parse("18:00:00")
]
count = 0
menus_id = Menu.all.map{|menu| menu.id}
date = Date.current
config = Config.find(1)

100.times do

  menu_id = menus_id.sample
  duration = Menu.find(menu_id).duration
  end_time = start_time[count] + duration.minutes
  menu = Menu.find(menu_id)
  user = User.find(user_id)

  if user.statuses.length > 0
    calendar_color = 'danger'
  else
    if user.note
      calendar_color = 'warning'
    else
      calendar_color = 'primary'
    end
  end
  # create Event
  new_event = Event.new(
    date: date,
    start: start_time[count],
    end: end_time,
    user_id: user_id,
    duration_total: menu.duration,
    status: "booked",
    price: menu.price,
    calendar_color: calendar_color,
    tax: config.tax * menu.price
  )
  new_event.save

  # update BusinessTime
  business_times = BusinessTime.where(date: date, time: start_time[count]...end_time)
  business_times.each do |business_time|
    business_time.available = false
    business_time.save
  end
  # create interval
  interval = Event.new(
    date: date,
    start: end_time,
    end: end_time + config.interval.minutes,
    user_id: 2,
    duration_total: config.interval,
    status: "booked",
    price: 0,
    calendar_color: 'gray',
    tax: 0
  )
  interval.save
  business_times = BusinessTime.where(date: date, time: end_time...(end_time + config.interval.minutes))
  business_times.each do |business_time|
    business_time.available = false
    business_time.save
  end
  # create EventMenu
  event_id = new_event.id
  EventMenu.create!(
    event_id: event_id,
    menu_id: menu_id,
    user_id: user_id,
    status: "booked",
  )
  if count == 3
    count = 0
    date += 1.days
    start_time = start_time.shuffle
  end
  user_id += 1
  count += 1
end


# This file will be executed once a day at 12:00 AM by Heroku Scheduler
# Comment out all seeds except BusinessTime below
# =======================

# time_slot = 1800 # 30 min
# date = Date.current.since(90.days)
# start_time = Time.zone.parse("10:00:00")
# 20.times do
#   BusinessTime.create!(
#     date: date,
#     time: start_time,
#     available: true
#   )
#   start_time += 1800.seconds # 30 min
# end

# =======================