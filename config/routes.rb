Rails.application.routes.draw do
  root "sessions#index"
  resources :users
  resources :temp
  resources :sessions, only: [:index, :create]
  get '/home' => "home#index"
  delete '/logout' => "sessions#destroy", as: 'logout'
end
