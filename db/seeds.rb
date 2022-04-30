# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# Menu.create!(title: "VIO", duration: Time.zone.parse('01:00'), price: 150, description: "Sensitive area")
# Menu.create!(title: "Arms", duration: Time.zone.parse('00:30'), price: 100, description: "Both arms")
# Menu.create!(title: "Legs", duration: Time.zone.parse('01:00'), price: 140, description: "Both legs")

# User.create!(
#   first_name: "Kaz",
#   last_name: "Takai",
#   password: "password",
#   email: "em@il.com",
#   phone: "347-695-5677",
#   gender: "male",
#   zip: 10001,
#   state: "NY",
#   city: "New York",
#   address: "545 W 30th St",
#   note: "This is a note for Kaz",
#   birthday: "1984-10-24",
#   status: "system"
# )

# Event.create!(
#   date: Date.current,
#   user_id: 1,
# )

time_slot = 1800 # 30 min
date = Date.current
90.times do
  start_time = Time.zone.parse("10:00:00")
  16.times do
    BusinessTime.create!(
      date: date,
      time: start_time,
      available: true
    )
    start_time += time_slot
  end
  date += 1
end


# This file will be executed once a day at 12:00 AM by Heroku Scheduler
# Comment out all seeds except BusinessTime below
# =======================

# time_slot = 1800 # 30 min
# date = Date.current
# start_time = Time.zone.parse("10:00:00")
#   16.times do
#     BusinessTime.create!(
#       date: date,
#       time: start_time,
#       available: true,
#       event_id: 1,
#     )
#     start_time += time_slot
#   end

# =======================