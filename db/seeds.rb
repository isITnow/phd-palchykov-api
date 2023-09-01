# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

PublicationPeriod.find_or_create_by_title("2021-present")
PublicationPeriod.find_or_create_by_title("2016-2020")
PublicationPeriod.find_or_create_by_title("2011-2015")
PublicationPeriod.find_or_create_by_title("2005-2010")
PublicationPeriod.find_or_create_by_title("Books and chapters")
