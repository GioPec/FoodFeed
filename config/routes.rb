Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => 'users/registrations' }

  #devise_for :users, controllers: { registrations: 'users/registrations' }

  root :to  => redirect('/users')

  resources :users do
    resources :recipes
  end

  get '/dailyrecipe' => 'recipes#daily'

  get '/discover' => 'recipes#discover'

  get '/users/:user_id/recipes/:recipe_id/like/new' => 'recipes#like', as: 'like'
  delete '/users/:user_id/recipes/:recipe_id/like/delete' => 'recipes#remove_like', as: 'remove_like'

end
