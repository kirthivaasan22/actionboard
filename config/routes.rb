Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :invoices, only: [:index, :new, :create, :edit, :destroy]

  match 'collections/:id', to: 'collections#create', via: [:post], as: :collection_create
  resources :collections, only: [:new, :destroy]
  
end
