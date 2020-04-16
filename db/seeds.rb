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

require "csv"

CSV.foreach('db/csv/users.csv', headers: true) do |row|
  user = User.new(
    name: row['name'],
    email: row['email'],
    password: row['password'],
    password_confirmation: row['password_confirmation']
  )
  user.skip_confirmation!
  user.save
end

CSV.foreach('db/csv/contents.csv', headers: true) do |row|
  Micropost.create!(
    user_id: row['user_id'],
    content: row['content'],
  )
end

users = User.all
user_1  = users.first
user_20 = users.last

user_1.follow(users[1])
user_1.follow(users[19])
user_20.follow(users[0])
user_20.follow(users[18])

18.times do |n|
  user = users[n + 1]
  following1 = users[n]
  user.follow(following1)
  following2 = users[n + 2]
  user.follow(following2)
end
