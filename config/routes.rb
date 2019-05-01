Rails.application.routes.draw do
  root to: 'tasks#index'

  resources :tasks

  namespace :admin do
    resources :users
  end
end
