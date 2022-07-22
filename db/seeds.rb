# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
PublicActivity.enabled = false
# User.create!(email: 'admin@gmail.com', password: '123456', password_confirmation: '123456')
# User.create!(email: 'student@gmail.com', password: '123456', password_confirmation: '123456')
# User.create!(email: 'shoira.shakirovna@gmail.com', password: '123456', password_confirmation: '123456')


5.times do
Course.create!([{
  title: Faker::Educator.course_name,
  description: Faker::TvShows::GameOfThrones.quote,
  short_description: Faker::TvShows::GameOfThrones.quote,
  user_id: User.last.id,
  language: "English",
  level: "Advanced",
  price: 10
  }]
)
end
5.times do
Course.create!([{
  title: Faker::Educator.course_name,
  description: Faker::TvShows::GameOfThrones.quote,
  short_description: Faker::TvShows::GameOfThrones.quote,
  user_id: User.first.id,
  language: "English",
  level: "Advanced",
  price: 0
  }]
)
end
# 2.times do
# Course.create!([{
#   title: Faker::Educator.course_name,
#   description: Faker::TvShows::GameOfThrones.quote,
#   short_description: Faker::TvShows::GameOfThrones.quote,
#   user_id: User.find(2),
#   language: "English",
#   level: "Advanced",
#   price: 15
#   }]
# )
# end