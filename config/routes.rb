Rails.application.routes.draw do
  root 'games#index'

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
