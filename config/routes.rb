Rails.application.routes.draw do
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
end
