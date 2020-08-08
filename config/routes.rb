Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => 'users/registrations' }

  #devise_for :users, controllers: { registrations: 'users/registrations' }

  root :to  => redirect('/users')

  resources :users do
    resources :recipes
  end
end
