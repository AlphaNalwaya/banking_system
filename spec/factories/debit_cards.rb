FactoryBot.define do
  factory :debit_card do
    card_no Faker::Account.card_number
    pin_no Faker::Number.pin_number(3)
  end
end