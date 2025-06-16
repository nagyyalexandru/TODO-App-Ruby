# Rails.application.routes.draw do
#   get "home/index"
#   get "sessions/new"
#   get "sessions/create"
#   get "sessions/destroy"
#   get "users/new"
#   get "users/create"
#   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

#   # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
#   # Can be used by load balancers and uptime monitors to verify that the app is live.
#   get "up" => "rails/health#show", as: :rails_health_check

#   # Render dynamic PWA files from app/views/pwa/*
#   get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
#   get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

#   # Defines the root path route ("/")
#   # root "posts#index"
# end
Rails.application.routes.draw do
  root "home#index"

  # Signup
  resources :users, only: [:new, :create]

  # Sessions (login)
  resources :sessions, only: [:new, :create, :destroy]

  # Provide convenient routes
  get "/login", to: "sessions#new", as: :login
  delete "/logout", to: "sessions#destroy", as: :logout

  # Separate route for recaptcha
  post "/recaptcha_verify", to: "users#create", as: :recaptcha_verify
end
