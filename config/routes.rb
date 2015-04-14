Rails.application.routes.draw do
  root 'adventures#index'
  resources :adventures, only: [:index, :show, :new, :create]
  devise_for :users
end
