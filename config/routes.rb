Rails.application.routes.draw do
  root 'adventures#index'
  devise_for :users
  resources :adventures do
    resources :adventure_memberships, only: [:create]
    resources :proposed_times, only: [:new, :create]
    resources :supplies, only: [:new, :create, :destroy, :update]
  end

  resources :proposed_times, only: :none do
    resources :proposed_time_votes, only: [:create, :destroy]
  end
end
