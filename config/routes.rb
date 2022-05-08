Rails.application.routes.draw do
  root 'games#index'

  resources :games, only: %i[ index show create destroy ], shallow: true do
    member do
      get :paticipate
    end
    resources :users, only: %i[ show edit ], shallow: true do
      post :authorize
      resources :user_hands, only: %i[ show edit destroy ]
      resources :user_supports, only: %i[ show edit destroy ]
    end
    resources :game_details, only: %i[ index show ]
  end
end
