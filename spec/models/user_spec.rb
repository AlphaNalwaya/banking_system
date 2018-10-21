require 'rails_helper'

RSpec.describe User, type: :model do
  context 'user validation' do
    it 'should valid user' do
      FactoryBot.build(:user).should be_valid
    end

    it 'should invalid without name' do
      FactoryBot.build(:User, name: nil).should_not be_valid
    end 

    it 'should invalid without address' do
      FactoryBot.build(:User, address: nil).should_not be_valid
    end 

    it 'should invalid without phone_no' do
      FactoryBot.build(:User, phone_no: nil).should_not be_valid
    end
  end  
end