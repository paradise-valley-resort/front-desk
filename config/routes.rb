Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :users, only: [:index, :new, :create, :edit, :update]

    root "dashboard#show"
  end
end
