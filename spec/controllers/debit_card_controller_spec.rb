require 'rails_helper'

RSpec.describe DebitCardController, type: :controller do
	context 'GET#index' do
    it 'has show all debit_cards successfully' do
      debit_card1 = FactoryBot.create(:debit_card)
      debit_card2 = FactoryBot.create(:debit_card)
      get :index
      expect(assigns(:debit_cards)).to include debit_card1
      expect(assigns(:debit_cards)).to include debit_card2
      expect(response).to have_http_status(:ok)
    end
  end

  context 'GET#show' do
    it 'has get debit_card successfully' do
      debit_card = FactoryBot.create(:debit_card)
      get :show, params: { id: debit_card.id }
      expect(assigns(:debit_card)).to eq(debit_card)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get invalid debit_card' do
      get :show, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end
  context 'GET#new' do
    it 'has get new debit_card successfully' do
      get :new
      expect(assigns(:debit_card).id).to eq(nil)
      expect(response).to have_http_status(:ok)
    end
  end

  context 'GET#edit' do
    it 'has get correct debit_card successfully' do
      debit_card = FactoryBot.create(:debit_card)
      get :edit, params: { id: debit_card.id }
      expect(assigns(:debit_card)).to eq(debit_card)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get debit_card with invalid id' do
      get :edit, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'has create debit_card successfully' do
      debit_card = FactoryBot.build(:debit_card)
      debit_card_params = {
        debit_card: {
          bank_id: debit_card.bank_id
        }
      }
      post :create, params: debit_card_params
      expect(assigns(:debit_card).card_no).to eq debit_card.card_no
      expect(assigns(:debit_card).expiry_date).to eq debit_card.expiry_date
      expect(assigns(:debit_card).issue_date).to eq debit_card.issue_date
      expect(assigns(:debit_card).pin_no).to eq debit_card.pin_id

      expect(assigns(:debit_card).bank_id).to eq debit_card.bank_id
      expect(response).to have_http_status(:created)
    end

    it 'has not create debit_card with invalid inputs' do
      atm_params = {
        debit_card: {
          card_no: nil, expiry_date: nil, issue_date: nil, pin_no: nil, bank_id: nil
        }
      }
      post :create, params: debit_card_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'has update debit_card successfully' do
      debit_card1 = FactoryBot.create(:debit_card)
      debit_card2 = FactoryBot.build(:debit_card)
      put :update,
          params: {
            id: debit_card1.id,
            debit_card: {
              card_no: debit_card2.card_no,
              expiry_date: debit_card2.expiry_date,

              bank_id: debit_card2.bank_id
            }
          }
      expect(assigns(:debit_card).id).to eq debit_card1.id
      expect(assigns(:debit_card).card_no).to eq debit_card2.card_no
      expect(assigns(:debit_card).expiry_date).to eq debit_card2.expiry_date

      expect(response).to have_http_status(:ok)
    end

    it 'has not update debit_card with invalid inputs' do
      atm1 = FactoryBot.create(:debit_card)
      put :update, params: {
        id: debit_card1.id, debit_card: {
          card_no: nil, expiry_date: nil
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'has not update debit_card with invalid debit_card' do
      debit_card = FactoryBot.create(:debit_card)
      put :update, params: {
        id: '123456', debit_card: {
          card_no: debit_card.card_no,
          expiry_date: debit_card.expiry_date
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'has destroy debit_card successfully' do
      debit_card = FactoryBot.create(:debit_card)
      delete :destroy, params: { id: debit_card.id }
      expect(assigns(:debit_card)).to eq debit_card
      expect(response).to have_http_status(:ok)
    end

    it 'has not destroy invalid debit_card' do
      delete :destroy, params: { id: '12345' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end