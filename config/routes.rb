Rails.application.routes.draw do
  # Auth routes
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'authentication#signup'
  get 'auth/logout', to: 'authentication#logout'
  
  # Todos & Items
  resources :todos do
    resources :items
  end
end