Rails.application.routes.draw do
  # Auth routes
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'authentication#signup'
  get 'auth/logout', to: 'authentication#logout'
  
  # Devise routes για το Portal
 devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # Pages
  root to: "pages#home"

  # Posts
  resources :posts

  # Users & Friendships
  resources :users, only: [:index] do
    member do
      post :add_friend
      delete :remove_friend # Προσθέσαμε αυτή τη γραμμή
    end
  end

  # Todos API
  resources :todos do
    resources :items
  end

    resources :conversations do
    resources :messages
  end

  # API Routes (κρατάμε αυτά από το Θέμα 2)
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'authentication#signup'
  resources :todos do
    resources :items
  end
end