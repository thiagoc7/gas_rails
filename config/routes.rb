Rails.application.routes.draw do

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

  root 'plans#measures'
end
