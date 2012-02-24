Borcly::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  namespace :admin do
    root :to =>  'dashboard#index'
  end

  root :to => 'home#index'
end
