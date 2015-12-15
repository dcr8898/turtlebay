Rails.application.routes.draw do

  # root to: '/'

  get    'register', to: 'users#new'
  get    'login',    to: 'sessions#new'
  post   'login',    to: 'sessions#create'
  delete 'logout',   to: 'sessions#destroy'

  resources :users, only: [:show, :create]

end
