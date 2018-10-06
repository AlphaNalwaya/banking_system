class Bank < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :account, dependent: :destroy
  validates :name, :address, presence: true
end