require 'rails_helper'

RSpec.describe User, type: :model do
  context 'user validation' do
    it 'should valid user' do
      expect(FactoryBot.build(:user)).should be_valid
    end

    it 'should invalid without name' do
      expect(FactoryBot.build(:User, name: nil)).should_not be_valid
    end 

    it 'should invalid without address' do
      expect(FactoryBot.build(:User, address: nil)).should_not be_valid
    end 

    it 'should invalid without phone_no' do
      expect(FactoryBot.build(:User, phone_no: nil)).should_not be_valid
    end

    it 'is invalid to take character for contact_no' do
      expect(FactoryBot.build(:user, contact_no: 'jhgjf12')).to be_invalid
    end

    it 'is invalid to exceed 10 digit  contact_no' do
      expect(
        FactoryBot.build(:user, contact_no: '9898797678912')
      ).to be_invalid
    end

    it 'is invalid to has less then 10 digit  contact_no' do
      expect(FactoryBot.build(:user, contact_no: '98912')).to be_invalid
    end
  end  
end