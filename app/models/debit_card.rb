class DebitCard < ApplicationRecord
  belongs_to :account
  has_many :transactions
  validates :card_no, :expiry_date, :issue_date, :pin_no, :account_id, presence: true
  validates :card_no, length: { is: 15 }, numericality: { only_integer: true }
  validates :pin_no, length: { is: 4 }, numericality: { only_integer: true }
  validate :expiry_date

  private

  def expiry_date
    if self.expiry_date < Date.issue_date
      errors.add(:expiry_date, "should can not be of past from issue_date")
    end
  end  
end