FactoryBot.define do
  factory :post do
    user
    body { Faker::Lorem.paragraph }
  end
end
