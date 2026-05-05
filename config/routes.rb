Rails.application.routes.draw do
  get 'users/new'
  resources :posts
  resources :users
  get "/", to: "home#top"
  resource :login, only: %i[ new create ]
  resource :logout, only: %i[ show ]
  resources :posts do
    resource :like, only: [:create, :destroy]
    # POST /posts/:post_id/like いいね
    # DELETE /posts/:post_id/like いいね取り消し
  end
end
