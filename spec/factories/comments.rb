FactoryBot.define do
  factory :comment do
    post
    author { Faker::Name.name }
    body { Faker::Lorem.paragraph }
  end
end
