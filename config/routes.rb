Rails.application.routes.draw do
  root 'jobs#index'

  get 'tags/:tag_name', action: :category, controller: :jobs, as: :tag
  resources :jobs, only: [:index, :show, :new, :create]

end
