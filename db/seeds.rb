# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Time.zone = 'Eastern Time (US & Canada)'

Menu.create!(title: "VIO", duration: 60, price: 150, description: "Sensitive area")
Menu.create!(title: "Arms", duration: 30, price: 100, description: "Both arms")
Menu.create!(title: "Legs", duration: 60, price: 140, description: "Both legs")

User.create!(
  first_name: "Kaz",
  last_name: "Takai",
  password: "password",
  email: "em@il.com",
  phone: "347-695-5677",
  gender: "male",
  zip: 10001,
  state: "NY",
  city: "New York",
  address: "545 W 30th St",
  note: "This is a note for Kaz",
  birthday: "1984-10-24",
  status: "system"
)

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


# This file will be executed once a day at 12:00 AM by Heroku Scheduler
# Comment out all seeds except BusinessTime below
# =======================

# time_slot = 1800 # 30 min
# date = Date.current
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