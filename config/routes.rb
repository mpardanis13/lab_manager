Rails.application.routes.draw do
  get "users/index"
  resources :posts
  get "pages/home"
  devise_for :users
  # Auth routes
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'authentication#signup'
  get 'auth/logout', to: 'authentication#logout'
  
  # Todos & Items
  resources :todos do
    resources :items
  end
  root to: "pages#home"

  resources :users, only: [:index] do
  member do
    post :add_friend
  end
end
end
