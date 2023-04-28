Rails.application.routes.draw do

  get 'categories/index'
  get 'categories/edit'
  get 'contents/index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 
  
  devise_scope :user do
    get "user/:id", :to => "users/registrations#detail"
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end

  root 'home#index'
  get 'about', to: 'home#about'
  get 'contact', to: 'home#contact'
  resources :contents
  resources :categories, expect: [:new, :show]
  resources :users, only: [:show]
  

  
end
