Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :users, only: [:index, :new, :create]

    root "dashboard#show"
  end
end
