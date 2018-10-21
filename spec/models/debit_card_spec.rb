require 'rails_helper'

RSpec.describe DebitCard, type: :model do
  context 'debit_card validation' do
    it 'should valid debit_card' do
      FactoryBot.build(:debit_card).should be_valid
    end
  end  

  context 'debit_card associations' do
    it 'should has many transaction' do
      @transaction = FactoryBot.create( bank_id: @bank.id)
      @transaction.debit_card.should include @transaction
    end  
  end  
end