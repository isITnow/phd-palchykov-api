# frozen_string_literal: true

FactoryBot.define do
  factory :news do
    body { Faker::Lorem.paragraph }
    date { 'January  4, 2023' }
    title { Faker::Lorem.paragraph }
  end
end
