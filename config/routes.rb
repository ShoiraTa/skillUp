Rails.application.routes.draw do
  get 'users/index'
  devise_for :users
  resources :courses
  resources :users, only: [:index]
  root 'pages#index'
end
