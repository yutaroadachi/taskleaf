Rails.application.routes.draw do
  root to: 'tasks#index'

  resources :tasks do
    post :confirm, action: :confirm_new,  on: :new
    post :import, on: :collection
  end

  namespace :admin do
    resources :users
  end

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
