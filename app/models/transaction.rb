class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :debit_card
  
  validates :amount, presence: true
  validates :operation, inclusion: { in: %w(deposite withdrawal)}
  after_save :withdrawal_amount_and_check_balance
  after_save :update_balance
  after_save :left_balance

  private

  def withdrawal_amount_and_check_balance
    if self.operation == 'withdrawal' && self.account.balance < self.amount 
      errors.add(:amount, "not permitted amount balance not enough")
    end
  end

  def update_balance
    if self.operation == 'deposite'
      new_balance = self.account.balance + self.amount
    esle
      new_balance = self.account.balance - self.amount
    end
    
    unless self.account.update.attributes(balance: new_balance)
      raise "request can not be processed"
    end


  def left_balance
    if self.operation == 'withdrawal'    
      new_balance = self.account.balance - self.amount
    end  
    unless self.account.update_attributes(balance: new_balance)
      raise "amount can not be withdraw"
    end
  end
end