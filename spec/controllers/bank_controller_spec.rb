require 'rails_helper'

RSpec.describe BankController, type: :controller do
	context 'GET#index' do
    it 'has show all banks successfully' do
      bank1 = FactoryBot.create(:bank)
      bank2 = FactoryBot.create(:bank)
      get :index
      expect(assigns(:banks)).to include bank1
      expect(assigns(:banks)).to include bank2
      expect(response).to have_http_status(:ok)
    end
  end

  context 'GET#show' do
    it 'has get bank successfully' do
      bank = FactoryBot.create(:bank)
      get :show, params: { id: bank.id }
      expect(assigns(:bank)).to eq(bank)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get invalid bank' do
      get :show, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'GET#new' do
    it 'has get new bank successfully' do
      get :new
      expect(assigns(:bank).id).to eq(nil)
      expect(assigns(:bank).name).to eq(nil)
      expect(assigns(:bank).address).to eq(nil)      
      expect(response).to have_http_status(:ok)
    end
  end

  context 'GET#edit' do
    it 'has get correct bank successfully' do
      bank = FactoryBot.create(:bank)
      get :edit, params: { id: bank.id }
      expect(assigns(:bank)).to eq(bank)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get bank with invalid id' do
      get :edit, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'has create bank successfully' do
      bank = FactoryBot.build(:bank)
      bank_params = {
        bank: {
          name: bank.name,
          address: bank.address,
        }
      }
      post :create, params: bank_params
      expect(assigns(:bank).name).to eq bank.name
      expect(assigns(:bank).address).to eq bank.address

      expect(response).to have_http_status(:created)
    end

    it 'has not create bank with invalid inputs' do
      bank_params = {
        bank: {
          name: nil, address:nil
        }
      }
      post :create, params: bank_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'has update bank successfully' do
      bank1 = FactoryBot.create(:bank)
      bank2 = FactoryBot.build(:bank)
      put :update,
          params: {
            id: bank1.id,
            bank: {
              name: bank2.name,
              address: bank2.address
            }
          }
      expect(assigns(:bank).id).to eq bank1.id
      expect(assigns(:bank).name).to eq bank2.name
      expect(assigns(:bank).address).to eq bank2.address

      expect(response).to have_http_status(:ok)
    end

    it 'has not update bank with invalid inputs' do
      bank1 = FactoryBot.create(:bank)
      put :update, params: {
        id: bank1.id, bank: {
          name: nil, address: nil
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'has not update bank with invalid bank' do
      bank = FactoryBot.create(:bank)
      put :update, params: { id: '123456', bank: {
        name: bank.name,
        address: bank.address,
      } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'has destroy bank successfully' do
      bank = FactoryBot.create(:bank)
      delete :destroy, params: { id: bank.id }
      expect(assigns(:bank)).to eq bank
      expect(response).to have_http_status(:ok)
    end

    it 'has not destroy invalid bank' do
      delete :destroy, params: { id: '12345' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end