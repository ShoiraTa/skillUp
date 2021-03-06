Rails.application.routes.draw do
  resources :enrollments do 
    get :my_students, on: :collection
  end
  
  get 'users/index'
  get 'activity', to: 'pages#activity'
  get 'statistics', to: 'pages#statistics'
  devise_for :users
  resources :courses do 
    member do 
      patch :approve
      patch :unapprove
      get :analytics
    end
    get :purchased, :pending_review, :my_courses, :unapproved, on: :collection
    resources :enrollments, only: [:new, :create]
    resources :lessons
  end
  resources :users, only: [:index, :edit, :show, :update]
  root 'pages#index'
end
