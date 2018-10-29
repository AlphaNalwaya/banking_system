require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context 'transaction validation' do
    it 'should valid transaction' do
      expect(FactoryBot.build(:transaction)).should be_valid
    end

    it 'should invalid without amount' do
      expect(FactoryBot.build(:transaction, amount: nil)).should_not be_valid
    end 
 
    it 'should invalid without operation' do
      expect(FactoryBot.build(:transaction, operation: nil)).should_not be_valid
    end

    it 'is invalid to has zero amount' do
      expect(FactoryBot.build(:transaction, amount: '0')).to be_invalid
    end
    
    it 'is invalid to has less then zero amount' do
      expect(FactoryBot.build(:transaction, amount: '-12')).to be_invalid
    end
  end    
end