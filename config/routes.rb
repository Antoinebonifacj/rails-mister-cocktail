Rails.application.routes.draw do
  get 'ingredients/index'
  get 'ingredients/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Cocktails routes
  root to: 'cocktails#index'
  resources :cocktails, only: %i[index show new create destroy] do
    resources :doses, only: %i[new create]
  end
  resources :doses, only: [:destroy]
  resources :ingredients, only: %i[index show]
end
