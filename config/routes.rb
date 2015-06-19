Rails.application.routes.draw do

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

  root 'stations#index'
end
