Rails.application.routes.draw do
  get 'tag_team_wrestlers/index'
  
  # Defines the root path route ("/")
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  
  get 'welcome/index'
  get 'welcome/about'

  resources :wrestlers
  resources :divisions, only: [:index, :show ]
  resources :promotions, only: [:index, :show ]

  get 'wrestlers/:id/dup_wrestler', to: 'wrestlers#dup_wrestler', as: :dup_wrestler

end
