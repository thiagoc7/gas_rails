Rails.application.routes.draw do

  resources :stations do
    resources :tanks
  end

  root 'stations#index'
end
