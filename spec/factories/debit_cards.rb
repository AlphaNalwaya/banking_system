FactoryBot.define do
  factory :creditcard do
    card_no { 1 }
    expiry_date { "2018-10-17" }
    issue_date { "2012-10-17" }
    cash_limit { 1 }
  end
end