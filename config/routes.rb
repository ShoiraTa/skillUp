Rails.application.routes.draw do
  get 'users/index'
  get 'pages/activity'
  devise_for :users
  resources :courses
  resources :users, only: [:index]
  root 'pages#index'
end
