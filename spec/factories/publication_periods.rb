FactoryBot.define do
  factory :publication_period do
    sequence(:title) do |n|
      init_year = 1990
      "#{init_year + n}-#{init_year + (n + 1)}"
    end
  end
end
