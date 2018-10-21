FactoryBot.define do
  factory :user do
    name { Faker::User.name }
    address { Faker::User.address }
    phone_no { Faker::Number.phone_number }
  end
end