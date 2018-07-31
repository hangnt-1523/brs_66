Rails.application.routes.draw do
  root "books#index"
  get "/help", to: "static_pages#help"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, only: %i(new create show)
  resources :books, only: %i(index show)
  resources :categories
  resources :comments
  resources :comments do
    member do
      get :new_reply
    end
  end
  resources :likes, expect: :index
end
