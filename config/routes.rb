Rails.application.routes.draw do
  root 'static#index'
  get '/terms', to: 'static#terms'
  get '/rules', to: 'static#rules'
  get '/credits', to: 'static#credits'
  get '/privacy_policy', to: 'static#privacy_policy'

  resources :games, only: %i[index show create destroy], shallow: true do
    member do
      get :paticipates
    end
    resources :users, only: %i[edit], shallow: true do
      post :authorize
      resources :user_hands, only: %i[show edit destroy]
      resources :user_supports, only: %i[edit destroy]
    end
    resources :game_details, only: %i[index]
  end

  resources :cpu_games, only: %i[show create destroy], shallow: true do
    resources :users, only: %i[show edit], shallow: true do
      resources :user_hands, only: %i[show edit destroy]
      resources :user_supports, only: %i[show edit destroy]
    end
    resources :game_details, only: %i[index]
  end

  get '/login_as/:user_id', to: 'dev/user_sessions#login_as' unless Rails.env.production?
end
