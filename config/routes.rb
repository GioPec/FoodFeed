Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #get '/' => 'users#index'    # mappa la homepage su '/'

  resources :users do
    resources :recipes
  end
end
