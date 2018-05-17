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
    resources :orders, only: [:create, :new, :destroy, :show]
    # Offers
    resources :offers, only: [:show]
    post 'offers/accept/:id', to: 'offers#accept', as: :accept_offer
    post 'offers/reject/:id', to: 'offers#reject', as: :reject_offer
  end

  namespace :admins do
    resource :customers, only: [:show]
    # Orders
    resources :orders, only: [:show]
    post 'orders/submit/:id', to: 'orders#submit', as: :submit_order
    post 'orders/reject/:id', to: 'orders#reject', as: :reject_order

    resources :offers, only: [:new, :show, :create]
  end

  get 'email', to: 'email#index'
end
