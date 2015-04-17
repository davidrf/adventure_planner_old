Rails.application.routes.draw do
  root 'adventures#index'
  devise_for :users
  resources :adventures do
    resources :adventure_memberships, only: [:create]
    resources :proposed_times, only: [:new, :create]
  end
end
