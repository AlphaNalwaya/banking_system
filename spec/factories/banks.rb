FactoryBot.define do
  factory :bank do
    name { Faker::Bank.name }
    address { Faker::Bank.address }
  end
end