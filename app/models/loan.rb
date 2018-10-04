class Loan < ApplicationRecord
  belongs_to :user
  validates :loan_type, :amount, :interest_rate, presence: true
  validates :amount, :interest_rate,  numericality: true
end