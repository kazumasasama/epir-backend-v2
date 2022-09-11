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

# statuses = [
#   'Medicine',
#   'Reffered',
#   'Sensitive for Pain',
#   'Admin',
#   'System'
# ]

# i = 0
# statuses.length.times do
#   Status.create!(
#     title: statuses[i]
#   )
# end

# require 'faker'

# business = Business.new(
#   name: 'Biznesu',
#   email: 'biznesu@biznesu.com',
#   phone: '111-111-1111',
#   state: 'NY',
#   city: 'New York',
#   address: '111 W 111th Street',
#   zip: '10011',
#   url: 'https://biznesu.netlify.app/',
#   insta: 'biznesuInsta',
#   twitter: 'biznesuTwitter',
#   facebook: 'biznesuFB'
# )

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

# birthday = Time.zone.parse('1950-01-01') 

# 100.times do
#   User.create!(
#     first_name: Faker::Name.unique.first_name,
#     last_name: Faker::Name.unique.last_name,
#     password: "password",
#     email: Faker::Internet.email(domain: 'biznesu'),
#     phone: Faker::PhoneNumber.cell_phone,
#     gender: Faker::Gender.binary_type,
#     zip: Faker::Address.zip,
#     state: Faker::Address.state_abbr,
#     city: Faker::Address.city,
#     address: Faker::Address.street_address,
#     note: Faker::JapaneseMedia::Doraemon.gadget,
#     birthday: birthday,
#     status: "User",
#     admin: false
#   )
#   birthday += 10.days
# end

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