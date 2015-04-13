Rails.application.routes.draw do
  root 'adventures#index'
  resources :adventures, only: [:index, :show]
  devise_for :users
end
