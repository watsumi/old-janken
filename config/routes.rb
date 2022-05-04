Rails.application.routes.draw do
  root 'home#welcome'
  get '/home', to: 'home#index'

  resources :games, only: %i[index create show] do
    member do
      get :spectator
      get :host
      get :guest
    end

    resources :users, only: %i[show] do
      member do
        get :details
        post :authorize
      end
      resources :game_details, only: %i[create]
    end
  end
end
