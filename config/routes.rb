Nailacenter::Application.routes.draw do

  resources :sessions, only: [:new, :create, :destroy]
  resources :users do
  	# averiguar despues porque estas rutas usan user_id y no id como parametro!
  	get :change_password
  	put :change_password_update
  end

  match '/dashboard', to: 'dashboard#index'

  # User Login / Logout
  match '/login',     to: 'sessions#new'
  match '/logout',    to: 'sessions#destroy', via: :delete
  
  # Default
  root :to => 'dashboard#index'
  
end