Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    namespace :users do
      get "/active", to: "actives#index", as: "actives"
      get "/deactive", to: "deactives#index", as: "deactives"
    end

    resources :users, only: [:index, :new, :create, :edit, :update]

    root "dashboard#show"
  end
end
