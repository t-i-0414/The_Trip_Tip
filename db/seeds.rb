# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rails db:seed command (or created
# alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' },
#   { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new(name:  "user",
                email: "user@example.com",
                password: "password",
                password_confirmation: "password")
user.skip_confirmation!
user.save

99.times do |n|
  name  = Faker::Name.name
  email = "user-#{n+1}@example.com"
  password = "password"
  user = User.new(name:  name,
                  email: email,
                  password: password,
                  password_confirmation: password)
  user.skip_confirmation!
  user.save
end