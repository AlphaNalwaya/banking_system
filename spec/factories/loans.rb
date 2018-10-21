FactoryBot.define do
  factory :loan do
    loan_type { 'Education_Loan Home_Loan Personal_loan Business_loan Car_Loan' }
    amount { Faker::Number.number(6) }
    interest_rate { Faker::Number.decimal(2, 2) }
  end
end