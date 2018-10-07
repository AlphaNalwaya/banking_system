class Account < ApplicationRecord
  belongs_to :bank
  belongs_to :user
  has_one :debit_card
  has_many :transactions
	
  validates :account_no, :balance, :bank_id, presence: true
  validate :balance_limit

  before_update :check_balance_non_zero, on: [:create]

  private

  def balance_limit
    if self.balance < 100
      errors.add(:balance, "should be at least 100")
    end	
  end

  def check_balance_non_zero
    if self.balance < 0
      errors.add(:balance, "can not open account")
    end
  end
end