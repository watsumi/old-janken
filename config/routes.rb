Rails.application.routes.draw do
  root 'home#welcome'
  get '/home', to: 'home#index'

  resources :games
  resources :users
  resources :game_details
end
