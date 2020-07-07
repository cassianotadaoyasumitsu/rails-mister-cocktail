Rails.application.routes.draw do
  root to: 'cocktails#index'

  resources :cocktails, except: :index do
    resources :doses, only: [:new, :create]
  end
  resources :doses, only: [:destroy]
  resources :ingredients
end
