Rails.application.routes.draw do

  root 'jobs#index'

  resources :jobs, only: [:index, :show, :new, :create]

end