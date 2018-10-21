FactoryBot.define do
  factory :account do
    account_no Faker::Bank.account_number
    balance Faker::Number.number(3)
    category { 'Saving Current' }
  end
end