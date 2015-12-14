Rails.application.routes.draw do

  get 'register', to: 'users#new'

  resources :users, only: [:create]

end
