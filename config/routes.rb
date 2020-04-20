# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Ingredients routes
  get 'ingredients', to: 'ingredients#index', as: 'ingredients'
  get 'ingredient/:id', to: 'ingredients#show', as: 'ingredient'
  # Create a cocktail and doses into the cocktail
    resources 'cocktails', only: %i[index show new create] do
      resources 'reviews', only: :create
      resources 'doses', only: %i[new create]
    end
  # Cocktails routes
  #resources :cocktails, only: %i[index show new create] do
  #  resources :doses, only: %i[new create]
  #end
  resources :doses, only: [:destroy]
  resources :ingredients, only: %i[index show]
end
