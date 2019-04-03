Rails.application.routes.draw do

  root 'items#index'

  get 'likes/create'
  get 'likes/destroy'

  post 'users/card_create',   to: 'users#card_create'
  delete 'users/card_delete', to: 'users#card_delete'

  match 'category_select',       to: 'items#category_select',       via: [:get, :post]
  match 'child_category_select', to: 'items#child_category_select', via: [:get, :post]

  devise_for :users, controllers: {
    registrations:      'users/registrations',
    sessions:           'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    get  'to_signup',      to: 'users/registrations#to_signup'
    post 'signup/profile', to: 'users/registrations#profile'
    post 'signup/address', to: 'users/registrations#address'
    post 'signup/credit',  to: 'users/registrations#credit'
  end

  resources :users,except: :show do
    get :logout,               on: :collection
    get :payment_method,       on: :collection
    get :card_registration,    on: :collection
    get :indentification,      on: :collection
    get :trading,              on: :collection
    get :purchased,            on: :collection
    get :exhibition,           on: :collection
    get :seller_trading,       on: :collection
    get :sold_page,            on: :collection
    get :notification,         on: :collection
    get :todo,                 on: :collection
    get :individual,           on: :member
    resources :likes,     only: :index
    resources :addresses, only: [:edit, :update]
    resources :lates,     only: :index do
      get :great,              on: :collection
      get :good,               on: :collection
      get :poor,               on: :collection
    end
    member do
     get :following, :followers
    end
  end

  scope :profiels do
    resources :users, only: :show
  end

  resources :items do
    get  :all_brands_show,      on: :collection
    get  :all_categories_show,  on: :collection
    get  :item_search_result,   on: :collection
    get  :buy,                  on: :member
    post :pay,                  on: :member
    get :buy,                  on: :collection
    get :all_brands_show,      on: :collection
    get :all_categories_show,  on: :collection
    get :item_search_result,   on: :collection
    get :buy,                  on: :member
    post :pay,                 on: :member
    get :trading_message,      on: :member
    post :trading_page,        on: :member
    post :message,             on: :member
    post :late,                on: :member
    resources :comments, only: [:create, :destroy]
    resources :likes,    only: [:create, :destroy]
  end

  resources :categories, only: :show do
    get :child_category,       on: :collection
    get :grand_child_category, on: :collection
  end

  resources :brands, only: :show do
    get :brand_show,          on: :member
  end

  resources :relationships, only: [:create, :destroy]

end
