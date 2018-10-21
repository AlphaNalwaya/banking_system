require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context 'transaction validation' do
    it 'should valid transaction' do
      FactoryBot.build(:transaction).should be_valid
    end

    it 'should invalid without amount' do
      FactoryBot.build(:transaction, amount: nil).should_not be_valid
    end 
 
    it 'should invalid without operation' do
      FactoryBot.build(:transaction, operation: nil).should_not be_valid
    end
  end    
end