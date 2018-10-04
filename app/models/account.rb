class Account < ApplicationRecord
    belongs_to :bank
	belongs_to :user
	has_many :transactions
	has_one :debit_card
	validates :account_no, :balance, :bank_id, presence: true
	validate :balance_limit

	private

	def balance_limit
		if self.balance < 100
			errors.add(:balance, "balance can not be less then 100")
		end	
	end
end