Rails.application.routes.draw do
  root 'games#index'
  get '/terms', to: 'static#terms'
  get '/rules', to: 'static#rules'
  get '/credits', to: 'static#credits'
  get '/privacy_policy', to: 'static#privacy_policy'

  resources :games, only: %i[index show create destroy], shallow: true do
    member do
      get :paticipates
    end
    resources :users, only: %i[show edit], shallow: true do
      post :authorize
      resources :user_hands, only: %i[show edit destroy]
      resources :user_supports, only: %i[show edit destroy]
    end
    resources :game_details, only: %i[index]
  end
end
