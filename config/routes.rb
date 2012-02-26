Borcly::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    get 'sign_in', :to => 'users/sessions#new', :as => :new_user_session
    get 'sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session
  end

  namespace :admin do
    resources :transactions do
      collection do
        get 'paid'
        get 'overdue'
        get 'broadcast'
      end
    end

    match 'accounts' => 'accounts#index', :as => :accounts
    match 'accounts/update' => 'accounts#update', :as => :update_account, :via => :post
    root :to =>  'transactions#index'
  end

  root :to => 'home#index'
end
