Rails.application.routes.draw do
  devise_for :users, path: :admin

  namespace :admin do
    namespace :rentals do
      get "/active", to: "actives#index", as: "actives"
      get "/deactive", to: "deactives#index", as: "deactives"
    end

    namespace :users do
      get "/active", to: "actives#index", as: "actives"
      get "/deactive", to: "deactives#index", as: "deactives"
    end

    resources :members, only: [:index, :new, :create, :edit, :update] do
      resources :deactivations, only: [:create], controller: "members/deactivations"
      resources :reactivations, only: [:create], controller: "members/reactivations"
    end

    resources :rentals, only: [:index, :new, :create, :edit, :update] do
      resources :deactivations, only: [:create], controller: "rentals/deactivations"
      resources :reactivations, only: [:create], controller: "rentals/reactivations"
    end

    resources :users, only: [:index, :new, :create, :edit, :update] do
      resources :deactivations, only: [:create], controller: "users/deactivations"
      resources :demotions, only: [:create], controller: "users/demotions"
      resources :promotions, only: [:create], controller: "users/promotions"
      resources :reactivations, only: [:create], controller: "users/reactivations"
    end

    root "dashboard#show"
  end
end
