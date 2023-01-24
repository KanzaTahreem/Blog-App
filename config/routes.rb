Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'users/:id', to: 'users#show'
  get 'users/:user_id/posts', to: 'posts#index'
  get 'users/:user_id/posts/:id', to: 'posts#show'

  # Defines the root path route ("/")
  # root "articles#index"
  root 'users#index'
end