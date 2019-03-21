Rails.application.routes.draw do

  root 'items#index'
  match 'category_select', to: 'items#category_select', via: [:get, :post]
  match 'child_category_select', to: 'items#child_category_select', via: [:get, :post]

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    post 'phone_number' => 'users/registrations#phone_number'
    post 'address' => 'users/registrations#address'
    post 'credit' => 'users/registrations#credit'
  end

  resources :users do
    get :to_signup,            on: :collection
    get :logout,               on: :collection
    get :payment_method,       on: :collection
    get :card_registration,    on: :collection
    get :indentification,      on: :collection
  end

  resources :items do
    get :buy,                  on: :collection
    get :all_brands_show,      on: :collection
    get :all_categories_show,  on: :collection
  end

end
