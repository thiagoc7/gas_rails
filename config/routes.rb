Rails.application.routes.draw do

  resources :measures

  resources :plans
  resources :stations do
    resources :tanks do
      collection { post :import }
    end
  end

  root 'stations#index'
end
