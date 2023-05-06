Rails.application.routes.draw do

  devise_for :admins, path: 'admin', controllers: {
    registrations: 'admins/registrations',
    sessions: 'admins/sessions'
  }
  
  devise_for :users, path: 'user', controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'   
  }
  
  devise_scope :admin do
    get 'admin/:id', :to => 'admins/registrations#detail'
    get 'signup', :to => 'admins/registrations#new'
    get 'login', :to => 'admins/sessions#new'
    get 'logout', :to => 'admins/sessions#destroy'
  end
  
  devise_scope :user do
    get 'user/:id', :to => 'users/registrations#detail'
    get 'signup', :to => 'users/registrations#new'
    get 'login', :to => 'users/sessions#new'
    get 'logout', :to => 'users/sessions#destroy'
  end

  root 'home#index'
  get 'about', to: 'home#about'
  get 'contact', to: 'home#contact'
  resources :contents do
    collection do
      get 'search'
    end
  end
  resources :categories, expect: [:new, :show]
  resources :users, only: [:show]
  resources :admins, only: [:show]
  resources :contacts, only: [:new, :create]
  post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
  
end
