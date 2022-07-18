Rails.application.routes.draw do
  get 'users/index'
  devise_for :users
  resources :courses
  root 'pages#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
