class DebitCard < ApplicationRecord
	belongs_to :account
	has_many :transactions
	validates :card_no, :expiry_date, :issue_date, :pin_no, :account_id, presence: true
	validates :card_no, length: { is: 15 }, numericality: { only_integer: true }
	validates :pin_no, length: { is: 4 }, numericality: { only_integer: true }
end