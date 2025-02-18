# frozen_string_literal: true

FactoryBot.define do
  factory :collaborator do
    sequence(:name) { Faker::Name.name }
    position { Faker::Job.position }
    category { %w[local international alumni].sample }
    sequence(:link) do |n|
      "https://www.dnu.dp.ua/#{n}"
    end
    photo do
      {
        io: File.open('spec/fixtures/default_image.jpg'),
        filename: 'default_image.jpg',
        content_type: 'image/jpeg'
      }
    end
  end
end
