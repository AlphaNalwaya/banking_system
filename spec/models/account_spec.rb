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

  context 'account associations' do
    before(:all) do
      @userid = FactoryBot.create(:user)
      @account = FactoryBot.create(:account, user_id: @userid.id)
    end
      
    it 'has many transactions' do
      @t1 = FactoryBot.create(:transaction, account_id: @account.id)
      @t2 = FactoryBot.create(:transaction, account_id: @account.id)
      expect(@account.transactions).to include(@t1)
      expect(@account.transactions).to include(@t2)
    end

    it 'has not unincluded transactions' do
      @a1 = FactoryBot.create(:account, user_id: @userid.id)
      @a2 = FactoryBot.create(:account, user_id: @userid.id)
      @t1 = FactoryBot.create(:transaction, account_id: @a1.id)
      @t2 = FactoryBot.create(:transaction, account_id: @a2.id)
      expect(@a1.transactions).to include(@t1)
      expect(@a1.transactions).not_to include(@t2)
      expect(@a2.transactions).to include(@t2)
      expect(@a2.transactions).not_to include(@t1)
    end

    it 'is belongs to user' do
      @a = FactoryBot.create(:account, user_id: @user.id)
      expect(@a.user.id).to eq(@user.id)
    end

    it 'is not belongs to invalid user' do
      @branch = FactoryBot.create(:branch, IFSC_code: 'SBBJ088')
      @user1 = FactoryBot.create(:user, branch_id: @branch.id)
      @user2 = FactoryBot.create(:user)

      @a = FactoryBot.create(:account, user_id: @user1.id)
      expect(@a.user.id).to eq(@user1.id)
      expect(@a.user.id).not_to eq(@user2.id)
    end
  end
end   