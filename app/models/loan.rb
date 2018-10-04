class Loan < ApplicationRecord
  belongs_to :user
  validates :loan_type, :amount, :interest_rate, presence: true
  validates :amount, :interest_rate, numericality: true
  validates :loan_type, inclusion: { in: %w(Home_Loan Car_Loan Education_Loan PersonaL_Loan Business_Loan)}
end