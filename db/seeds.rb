# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Time.zone = 'Eastern Time (US & Canada)'

# Menu.create!(title: "VIO", duration: 60, price: 130, description: "Sensitive area")
# Menu.create!(title: "Arms", duration: 30, price: 100, description: "Both arms")
# Menu.create!(title: "Legs", duration: 90, price: 150, description: "Both legs")

# User.create!(
#   first_name: "Master",
#   last_name: "Admin",
#   password: "password",
#   email: "test@test.com",
#   phone: "123-456-7890",
#   gender: "N/A",
#   zip: 10001,
#   state: "NY",
#   city: "New York",
#   address: "545 W 30th St",
#   note: "This is a note for Master Admin",
#   birthday: "1900-01-01",
#   status: "System",
#   admin: true
# )

# User.create!(
#   first_name: "User",
#   last_name: "1",
#   password: "password",
#   email: "user@user.com",
#   phone: "098-765-4321",
#   gender: "N/A",
#   zip: 10001,
#   state: "NY",
#   city: "New York",
#   address: "545 W 31th St",
#   note: "This is a note for User1",
#   birthday: "1900-01-01",
#   status: "System",
#   admin: false
# )

# date = Date.current

# 90.times do
#   start_time = Time.zone.parse("10:00:00")
#   20.times do
#     BusinessTime.create!(
#       date: date,
#       time: start_time,
#       available: true
#     )
#     start_time += 1800.seconds # 30 min
#   end
#   date += 1
# end


# This file will be executed once a day at 12:00 AM by Heroku Scheduler
# Comment out all seeds except BusinessTime below
# =======================

time_slot = 1800 # 30 min
date = Date.current.since(90.days)
start_time = Time.zone.parse("10:00:00")
20.times do
  BusinessTime.create!(
    date: date,
    time: start_time,
    available: true
  )
  start_time += 1800.seconds # 30 min
end

# =======================