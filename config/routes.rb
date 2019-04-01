Rails.application.routes.draw do

  root 'items#index'

  get 'likes/create'
  get 'likes/destroy'

  post 'users/card_create' => 'users#card_create'
  delete 'users/card_delete' => 'users#card_delete'

  match 'category_select', to: 'items#category_select', via: [:get, :post]
  match 'child_category_select', to: 'items#child_category_select', via: [:get, :post]

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    get  'to_signup' => 'users/registrations#to_signup'
    post 'signup/profile' => 'users/registrations#profile'
    post 'signup/address' => 'users/registrations#address'
    post 'signup/credit' => 'users/registrations#credit'
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
    resources :addresses, only: [:edit, :update]
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
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

  resources :categories, only: :show do
    get :child_category,       on: :collection
    get :grand_child_category, on: :collection
  end

  resources :mypages do
  end

  resources :brands, only: :show do
    get :brand_show,          on: :member
  end

end
