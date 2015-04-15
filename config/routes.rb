Rails.application.routes.draw do
  root 'adventures#index'
  resources :adventures do
    resources :adventure_memberships, only: [:create]
  end
  devise_for :users
end
