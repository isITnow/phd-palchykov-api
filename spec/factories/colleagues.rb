# frozen_string_literal: true

FactoryBot.define do
  factory :colleague do
    sequence(:email) { Faker::Internet.email }
    sequence(:name) { Faker::Name.name }
    phone { Faker::PhoneNumber.phone_number_with_country_code }
    photo do
      {
        io: File.open('spec/fixtures/default_image.jpg'),
        filename: 'default_image.jpg',
        content_type: 'image/jpeg'
      }
    end
    position { Faker::Job.position }
  end
end
