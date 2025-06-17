Rails.application.routes.draw do
  root "home#index"
  
  # Signup
  resources :users, only: [ :new, :create ]

  # Sessions (login)
  resources :sessions, only: [ :new, :create, :destroy ]

  # Provide convenient routes
  get "/login", to: "sessions#new", as: :login
  delete "/logout", to: "sessions#destroy", as: :logout

  # Separate route for recaptcha
  post "/recaptcha_verify", to: "users#create", as: :recaptcha_verify

  # API routes
  resources :todo_lists do
  resources :tasks, only: [:create, :update, :destroy] do
    member do
      patch :update_position
    end
  end
  resources :list_shares, only: [:create, :destroy]
end
end