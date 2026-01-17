Rails.application.routes.draw do
  # Auth routes
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'authentication#signup'
  
  # Todos & Items
  resources :todos do
    resources :items
  end
end