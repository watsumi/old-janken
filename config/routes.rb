Rails.application.routes.draw do
  root 'home#welcome'
  get '/home', to: 'home#index'

  resources :games, shallow: true do
    member do
      get :paticipate
    end
    resources :users, shallow: true do
      resources :user_hands
      resources :user_supports
      post :authorize
    end
    resources :game_details
  end

  resources :spies do
    collection do
      post 'clearance'
    end
  end
end
