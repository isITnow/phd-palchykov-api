# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Api::V1::PublicationPeriod.find_or_create_by(title: "2021-present")
Api::V1::PublicationPeriod.find_or_create_by(title: "2016-2020")
Api::V1::PublicationPeriod.find_or_create_by(title: "2011-2015")
Api::V1::PublicationPeriod.find_or_create_by(title: "2005-2010")
Api::V1::PublicationPeriod.find_or_create_by(title: "Books and chapters")

# Api::V1::User.first_or_create(username: "Rom the Dev",
#                       email: 'rom@example.com',
#                       password: 'password',
#                       password_confirmation: 'password',
#                       role: Api::V1::User.roles[:admin])

10.times do
  body = Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 4)
  Api::V1::Post.create(body:, user_id: Api::V1::User.first.id)
end

posts = Api::V1::Post.all

posts.each do |post|
  5.times do
    body = Faker::Lorem.paragraph(sentence_count: 3, supplemental: true, random_sentences_to_add: 2)
    post.comments.create(body:)
  end
end