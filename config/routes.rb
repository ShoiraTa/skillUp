Rails.application.routes.draw do
  resources :enrollments
  
  get 'users/index'
  get 'pages/activity'
  devise_for :users
  resources :courses do 
    resources :enrollments, only: [:new, :create]
    resources :lessons
  end
  resources :users, only: [:index, :edit, :show, :update]
  root 'pages#index'
end
