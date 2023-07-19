Rails.application.routes.draw do
  devise_for :users 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :edit, :update, :destroy]
      resources :likes, only: [:create]
    end
  end

  namespace :api do
    post 'login', to: 'login#index'
    resources :users, only: [] do
      resources :posts, only: [:index] do
        resources :comments, only: [:index, :create]
      end
    end
  end

  # Defines the root path route ("/")
  # root "articles#index" 
  root 'users#index', as: 'home'
end