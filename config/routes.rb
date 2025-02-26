Rails.application.routes.draw do
  resources :vat_rates
  resources :items
  resources :companies do
    resources :answers
    resources :surveys
    resources :questions
    resources :customers
    resources :users
    resources :gcra_settings
    resources :regions
  end

  resources :answers
  resources :surveys
  resources :questions
  resources :customers
  resources :regions
  resources :users do
    member do
      get :otp
      post :verify_totp
    end
  end
  resources :gcra_settings

  root to: 'companies#index'
end
