Rails.application.routes.draw do
  # Swagger Documentation Routes
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'


  # Auth routes για το API (Θέμα 2)
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'authentication#signup'
  get 'auth/logout', to: 'authentication#logout'
  
  # Devise routes για το Portal (Θέμα 1)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # Pages
  root to: "pages#home"

  # Posts
  resources :posts

  # Users & Friendships
  resources :users, only: [:index] do
    member do
      post :add_friend
      delete :remove_friend
    end
  end

  # Chat System
  resources :conversations do
    resources :messages
  end

  # Todos & Items API (Θέμα 2)
  resources :todos do
    resources :items
  end
end