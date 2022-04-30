Rails.application.routes.draw do
  root 'home#welcome'
  get '/home', to: 'home#index'

  resources :games
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
