class User < ApplicationRecord
  belongs_to :bank
  has_one :account
  has_many :loans
  validates :name, :bank_id, :address, :phone_no, presence: true
  validates :phone_no, length: { is: 10 }, numericality: { only_integer: true }
end