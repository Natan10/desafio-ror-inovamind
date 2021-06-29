FactoryBot.define do
  factory :quote do
    quote { Faker::Lorem.paragraph }
    author { Faker::Name.name }
    author_about { Faker::Internet.url }
    tags { ["love","life","humor","books","reading"].sample(rand(1..4)) }
  end
end
