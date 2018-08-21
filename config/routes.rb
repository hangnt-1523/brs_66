Rails.application.routes.draw do
  devise_for :users,
    controllers: {confirmation: "confirmations",
      omniauth_callbacks: "users/omniauth_callbacks"}

  root "books#index"
  get "/help", to: "static_pages#help"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/add_cart/:book_id", to: "carts#add_cart", as: :add_cart
  delete "/remove_book/:book_id", to: "carts#remove_book", as: :remove_book

  namespace :admin do
    resources :authors, except: :destroy
    resources :books, except: :show
    resources :orders, only: %i(index update)
  end

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :books, only: %i(index show)
  resources :carts, only: [:index] do
    collection do
      post :update_quantity
    end
  end
  resources :orders, :categories
  resources :comments do
    member do
      get :new_reply
    end
  end
  resources :likes, expect: :index
  post "/rate", to: "rater#create", as: "rate"
  resources :mark_books, only: %i(create update)
  resources :favorites
  resources :orders, only: %i(index new create destroy)

  resources :follows, only: %i(create destroy create_author destroy_author)
  post "/follows/create_author", to: "follows#create_author", as: :create_author
  delete "/follows/destroy_author/:id", to: "follows#destroy_author", as: :destroy_author

  resources :authors
  resources :authors do
    member do
      get :following, :follower_authors
    end
  end
end
