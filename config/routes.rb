Hubzubub::Application.routes.draw do
  resources :search_sets


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users

  resources :persons do
    resources :activities
  end

  resources :websites do
    resources :searches do
      resources :runs, controller: :search_runs
    end
		resources :params, controller: :website_params
  end
end