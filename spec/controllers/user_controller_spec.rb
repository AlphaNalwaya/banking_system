require 'rails_helper'

RSpec.describe UserController, type: :controller do
	context 'GET#index' do
    it 'has show all users successfully' do
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      get :index
      expect(assigns(:users)).to include user1
      expect(assigns(:users)).to include user2
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#show' do
    it 'has get user successfully' do
      user = FactoryBot.create(:user)
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get invalid user' do
      get :show, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end
  context 'GET#new' do
    it 'has get new user successfully' do
      get :new
      expect(assigns(:user).id).to eq(nil)
      expect(assigns(:user).name).to eq(nil)
      expect(assigns(:user).address).to eq(nil)
      expect(assigns(:user).phone_no).to eq(nil)
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#edit' do
    it 'has get correct user successfully' do
      user = FactoryBot.create(:user)
      get :edit, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get user with invalid id' do
      get :edit, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'has create user successfully' do
      user = FactoryBot.build(:user)
      user_params = {
        user: {
          name: user.name,
          address: user.address,
          phone_no: user.phone_no,
        }
      }
      post :create, params: user_params
      expect(assigns(:user).name).to eq user.name
      expect(assigns(:user).address).to eq user.address
      expect(assigns(:user).phone_no).to eq user.phone_no
      expect(response).to have_http_status(:created)
    end

    it 'has not create user with invalid inputs' do
      user_params = {
        user: {
          name: nil,
          address: nil,
          phone_no: nil,
        }
      }
      post :create, params: user_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'has update user successfully' do
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.build(:user)
      put :update,
          params: {
            id: user1.id,
            user: {
              name: user2.name,
              address: user2.address,
              contact_no: user2.contact_no,
            }
          }
      expect(assigns(:user).id).to eq user1.id
      expect(assigns(:user).name).to eq user2.name
      expect(assigns(:user).address).to eq user2.address
      expect(assigns(:user).phone_no).to eq user2.phone_no
      expect(response).to have_http_status(:ok)
    end

    it 'has not update user with invalid inputs' do
      user1 = FactoryBot.create(:user)
      put :update, params: {
        id: user1.id, user: {
          name: nil,
          address: nil,
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'has not update user with invalid user' do
      user = FactoryBot.create(:user)
      put :update, params: { id: '123456', user: {
        name: user.name,
        address: user.address,
      } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'has destroy user successfully' do
      user = FactoryBot.create(:user)
      delete :destroy, params: { id: user.id }
      expect(assigns(:user)).to eq user
      expect(response).to have_http_status(:ok)
    end

    it 'has not destroy invalid user' do
      delete :destroy, params: { id: '12345' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

end
