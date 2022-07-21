# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# User.create!(email: 'admin2@example.com', password: '1234567', password_confirmation: '1234567')
PublicActivity.enabled = false
10.times do
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