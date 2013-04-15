Nailacenter::Application.routes.draw do
  resources :session, only: [:new, :create, :destroy]

  match '/dashboard', to: 'dashboard#index'

  # User Login / Logout
  match '/login',     to: 'sessions#new'
  match '/logout',    to: 'sessions#destroy', via: :delete
  
  # Default
  root :to => 'dashboard#index'
end
