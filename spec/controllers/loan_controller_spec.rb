require 'rails_helper'

RSpec.describe LoanController, type: :controller do
	context 'GET#index' do
    it 'has show all loans successfully' do
      loan1 = FactoryBot.create(:loan)
      loan2 = FactoryBot.create(:loan)
      get :index
      expect(assigns(:loans)).to include loan1
      expect(assigns(:loans)).to include loan2
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#show' do
    it 'has get loan successfully' do
      loan = FactoryBot.create(:loan)
      get :show, params: { id: loan.id }
      expect(assigns(:loan)).to eq(loan)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get invalid loan' do
      get :show, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end
  context 'GET#new' do
    it 'has get new loan successfully' do
      get :new
      expect(assigns(:loan).id).to eq(nil)
      expect(assigns(:loan).loan_type).to eq(nil)
      expect(assigns(:loan).amount).to eq(nil)
      expect(assigns(:loan).interest_rate).to eq(nil)
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#edit' do
    it 'has get correct loan successfully' do
      loan = FactoryBot.create(:loan)
      get :edit, params: { id: loan.id }
      expect(assigns(:loan)).to eq(loan)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get loan with invalid id' do
      get :edit, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'has create loan successfully' do
      loan = FactoryBot.build(:loan)
      loan_params = {
        loan: {
          loan_type: loan.loan_type,
          amount: loan.amount,
          interest_rate: loan.interest_rate,
          user_id: loan.user_id
        }
      }
      post :create, params: loan_params
      expect(assigns(:loan).loan_type).to eq loan.loan_type
      expect(assigns(:loan).amount).to eq loan.amount
      expect(assigns(:loan).interest_rate).to eq loan.interest_rate
      expect(assigns(:loan).user_id).to eq loan.user_id
      expect(response).to have_http_status(:created)
    end

    it 'has not create loan with invalid inputs' do
      loan_params = {
        loan: {
          loan_type: nil,
          amount: nil,
          interest_rate: nil,
          user_id: nil
        }
      }
      post :create, params: loan_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'has update loan successfully' do
      loan1 = FactoryBot.create(:loan)
      loan2 = FactoryBot.build(:loan)
      put :update,
          params: {
            id: loan1.id,
            loan: {
              loan_type: loan2.loan_type,
              amount: loan2.amount,
              interest_rate: loan2.interest,
              user_id: loan2.user_id
            }
          }
      expect(assigns(:loan).id).to eq loan1.id
      expect(assigns(:loan).loan_type).to eq loan2.loan_type
      expect(assigns(:loan).amount).to eq loan2.amount
      expect(assigns(:loan).interest_rate).to eq loan2.interest_rate
      expect(assigns(:loan).user_id).to eq loan2.user_id
      expect(response).to have_http_status(:ok)
    end

    it 'has not update loan with invalid inputs' do
      loan1 = FactoryBot.create(:loan)
      put :update, params: {
        id: loan1.id, loan: {
          loan_type: nil, amount: nil, interest_rate: nil
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'has not update loan with invalid loan' do
      loan = FactoryBot.create(:loan)
      put :update, params: {
        id: '123456', loan: {
          loan_type: loan.loan_type,
          amount: loan.amount,
          interest_rate: loan.interest_rate,
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'has destroy loan successfully' do
      loan = FactoryBot.create(:loan)
      delete :destroy, params: { id: loan.id }
      expect(assigns(:loan)).to eq loan
      expect(response).to have_http_status(:ok)
    end

    it 'has not destroy invalid loan' do
      delete :destroy, params: { id: '12345' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end