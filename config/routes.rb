Rails.application.routes.draw do
  root 'jobs#index'

  get 'categories/:tag_id', action: :category, controller: :jobs, as: :category
  resources :jobs, only: [:index, :show, :new, :create]

end