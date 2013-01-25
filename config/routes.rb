Hubzubub::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :persons do
	resources :activities
  end
  resources :businesses
  resources :profiles
  resources :websites
end