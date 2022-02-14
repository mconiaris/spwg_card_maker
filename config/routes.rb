Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'main/home'

  get 'main/home'
  get 'main/about'

  resources :wrestlers

  resources :divisions

  resources :promotions

end
