Rails.application.routes.draw do
  get 'users/index'
  resources :posts
  root "posts#index"
end
