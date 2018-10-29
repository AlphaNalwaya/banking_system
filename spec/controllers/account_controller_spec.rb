require 'rails_helper'

RSpec.describe AccountController, type: :controller do
  before(:all) do
    account = FactoryBot.create(:account)

	context 'GET#index' do
    it 'has show all accounts successfully' do
      account1 = FactoryBot.create(:account)
      account2 = FactoryBot.create(:account)
      get :index
      expect(assigns(:accounts)).to include account1
      expect(assigns(:accounts)).to include account2
      expect(response).to have_http_status(:ok)
    end
  end

  context 'GET#show' do
    it 'has get account successfully' do
      get :show, params: { id: account.id }
      expect(assigns(:account)).to eq(account)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get invalid account' do
      get :show, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'GET#new' do
    it 'has get new account successfully' do
      get :new
      expect(assigns(:account).id).to eq(nil)
      expect(assigns(:account).account_no).to eq(nil)
      expect(assigns(:account).category).to eq(nil)
      expect(assigns(:account).balance).to eq(nil)
      expect(response).to have_http_status(:ok)
    end
  end
  
  context 'GET#edit' do
    it 'has get correct account successfully' do
      get :edit, params: { id: account.id }
      expect(assigns(:account)).to eq(account)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get account with invalid id' do
      get :edit, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'has create account successfully' do
      account = FactoryBot.build(:account)
      account_params = {
        account: {
          account_no: account.account_no,
          category: account.category,
          balance: account.balance,
        }
      }
      post :create, params: account_params
      expect(assigns(:account).account_no).to eq account.account_no
      expect(assigns(:account).category).to eq account.category
      expect(assigns(:account).balance).to eq account.balance
      expect(response).to have_http_status(:created)
    end

    it 'has not create account with invalid inputs' do
      account_params = {
        account: {
          account_no: nil, category: nil, balance: nil, date_of_opening: nil
        }
      }
      post :create, params: account_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'has update account successfully' do
      @b = FactoryBot.create(:bank, bank_id: xyz)
      @u = FactoryBot.create(:user, branch_id: @b.id)
      account1 = FactoryBot.create(:account)
      account2 = FactoryBot.build(:account)
      put :update,
          params: {
            id: account1.id,
            account: {
              account_no: account2.account_no,
              category: account2.category,
              balance: account2.balance,
            }
          }
      expect(assigns(:account).id).to eq account1.id
      expect(assigns(:account).account_no).to eq account2.account_no
      expect(assigns(:account).category).to eq account2.category
      expect(assigns(:account).balance).to eq account2.balance
      expect(response).to have_http_status(:ok)
    end

    it 'has not update account with invalid inputs' do
      account1 = FactoryBot.create(:account)
      put :update, params: {
        id: account1.id, account: {
          account_no: nil, category: nil, balance: nil
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'has not update account with invalid account' do
      put :update, params: { id: '123456', account: {
        account_no: account.account_no,
        category: account.category,
        balance: account.balance
      } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'has destroy account successfully' do
      delete :destroy, params: { id: account.id }
      expect(assigns(:account)).to eq account
      expect(response).to have_http_status(:ok)
    end

    it 'has not destroy invalid account' do
      delete :destroy, params: { id: '12345' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end