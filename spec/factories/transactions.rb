FactoryBot.define do
  factory :transaction do
    operation { 'withdrawal deposite' }
    amount { Faker::Number.decimal(5, 2) }
  end
end