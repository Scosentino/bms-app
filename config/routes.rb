Rails.application.routes.draw do
  devise_for :users, :controllers => {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

  # Create Order from footer
  post '/create_order_from_footer', to: 'home#create_order_from_footer', as: :create_order_from_footer

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :admins, only: [:index]
  resources :customers, only: [:index]

  resource :wizard do
    get :step1
    get :step2
    get :step3
    get :step4
    get :step5

    post :validate_step
  end

  # Contract
  get '/generate_policy', to: 'generate_contracts#policy', as: :generate_contract
  get '/generate_merchant', to: 'generate_contracts#merchant_agreement', as: :generate_merchant_agreement

  # Check email present
  get 'check_email' => 'application#check_email'

  # Admins Settings
  patch 'update_admin_info', to: 'admins#update_info', as: :update_admin_info
  patch 'update_admin_password', to: 'admins#update_password', as: :update_admin_password

  # Customers Settings
  patch 'update_customer_info', to: 'customers#update_info', as: :update_customer_info
  patch 'update_customer_password', to: 'customers#update_password', as: :update_customer_password
  patch 'update_customer_business', to: 'customers#update_business', as: :update_customer_business
  patch 'update_customer_payment_method', to: 'customers#update_payment_method', as: :update_customer_payment_method


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
end
