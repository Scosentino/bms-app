Rails.application.routes.draw do
  devise_for :users, :controllers => {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

  resources :admins, only: [:index]
  resources :customers, only: [:index]

  namespace :customers do
    resources :orders, only: [:create, :new, :index, :destroy, :show]
  end

  namespace :admins do
    resource :customers, only: [:show]
    resources :orders, only: [:show]
  end
end
