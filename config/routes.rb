Rails.application.routes.draw do
  get 'users/new'
  resources :posts
  resources :users
  get "/", to: "home#top"
  resource :login, only: %i[ new create ]
  resource :logout, only: %i[ show ]
end
