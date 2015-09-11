Rails.application.routes.draw do

  resources :banks

  resources :boletos do
    collection do
      get :generate
      get :generate_many
    end
  end

  resources :clients
  resources :prices
  resources :suppliers
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :plans do
    collection do
      get :measures
      get :forecast
      get :buy
    end
  end

  resources :stations do
    resources :tanks do
      collection { post :import }
    end
  end

  # root 'plans#measures'
  root 'boletos#index'
end
