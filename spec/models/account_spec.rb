require 'rails_helper' 

RSpec.describe Account, type: :model do
  context 'account validation' do
    before(:all) do
      @account = FactoryBot.build(:account)
    end

    it 'should valid account' do
      FactoryBot.build(:account).should be_valid
    end

    it 'should invalid without category' do
      FactoryBot.build(:account, category: nil).should_not be_valid
    end 

    it 'should invalid without account_no' do
      FactoryBot.build(:account, acccount_no: nil).should_not be_valid
    end 
 
    it 'should invalid without a name' do
      FactoryBot.build(:account, name: nil).should_not be_valid
    end

    it 'should invalid without a address' do
      FactoryBot.build(:account, address: nil).should_not be_valid
    end

    it 'should invalid without a balance' do
      FactoryBot.build(:account, balance: nil).should_not be_valid
    end

    it 'should invalid without valid_amount' do
      FactoryBot.build(:account, valid_amount: 00.00).should_not be_valid
    end
  
    it "has a unique accountnumber" do
      account = build(:account, account_no: "xyz123")
      expect(account).to_not be_valid
    end

    it "has a balance less then 100" do
      account = build(:account, balance: "less then 100")
      expect(account).to_not be_valid
    end
  end
end   