Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :accounts
  resources :banks
  resources :debit_cards
  resources :loan
  resources :transactions
  resources :users

end