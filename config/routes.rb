Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users
  resources :posts do
    resources :comments
    post '/post/:post_id/upvote', to: 'posts#upvote', as: 'upvote'
    post '/post/:post_id/downvote', to: 'posts#downvote', as: 'downvote'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
