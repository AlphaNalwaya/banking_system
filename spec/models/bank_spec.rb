require 'rails_helper'

RSpec.describe Bank, type: :model do
  context 'bank validation' do
    it 'should valid bank' do
      FactoryBot.build(:bank).should be_valid
    end

    it 'should invalid without amount' do
      FactoryBot.build(:bank, amount: nil).should_not be_valid
    end 

    it 'should invalid without date' do
      FactoryBot.build(:bank, date: nil).should_not be_valid
    end 
 
    it 'should invalid without operation' do
      FactoryBot.build(:bank, operation: nil).should_not be_valid
    end
  end
end  