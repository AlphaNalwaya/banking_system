require 'rails_helper'

RSpec.describe Loan, type: :model do
  context 'loan validation' do
    it 'should valid loan' do
      FactoryBot.build(:loan).should be_valid
    end

    it 'should invalid without type' do
      FactoryBot.build(:loan, type: nil).should_not be_valid
    end 

    it 'should invalid without amount' do
      FactoryBot.build(:loan, amount: nil).should_not be_valid
    end 

    it 'should invalid without interest_rate' do
      FactoryBot.build(:loan, interest_rate: nil).should_not be_valid
    end 
  end
end 