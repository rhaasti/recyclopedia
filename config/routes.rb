Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
resources :products, only: [:index, :show] do
  collection do
    get :search_by_material
  end
end

resources :lists, only: [:index, :show, :new, :create]

resources :bookmarks, only: [:create]
end

