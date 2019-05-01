Rails.application.routes.draw do
  root to: 'tasks#index'

  resources :tasks
  get  '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  namespace :admin do
    resources :users
  end
end
