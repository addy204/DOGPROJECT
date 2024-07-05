Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'home/index'
  get 'about', to: 'about#index'
  root 'home#index'

  resources :breeds, only: [:index, :show] do
    resources :sub_breeds, only: [:show], as: 'sub_breeds'
  end

  resources :owners, only: [:index, :show]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
end
