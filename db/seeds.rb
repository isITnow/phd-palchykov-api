# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# PublicationPeriod.find_or_create_by(title: "2021-present")
# PublicationPeriod.find_or_create_by(title: "2016-2020")
# PublicationPeriod.find_or_create_by(title: "2011-2015")
# PublicationPeriod.find_or_create_by(title: "2005-2010")
# PublicationPeriod.find_or_create_by(title: "Books and chapters")

# User.first_or_create(username: "Rom the Dev",
#                       email: 'rom@example.com',
#                       password: 'password',
#                       password_confirmation: 'password',
#                       role: User.roles[:admin])

# 10.times do
#   body = Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 4)
#   Post.create(body:, user_id: User.first.id)
# end

# posts = Post.all

# posts.each do |post|
#   5.times do
#     body = Faker::Lorem.paragraph(sentence_count: 3, supplemental: true, random_sentences_to_add: 2)
#     post.comments.create(body:)
#   end
# end