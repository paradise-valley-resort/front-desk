Rails.application.routes.draw do
  devise_for :users, path: :admin

  namespace :admin do
    namespace :bookings do
      get "/approved", to: "approveds#index", as: "approveds"
      get "/paid", to: "paids#index", as: "paids"
      get "/pending", to: "pendings#index", as: "pendings"
      get "/rejected", to: "rejecteds#index", as: "rejecteds"
    end

    namespace :members do
      get "/active", to: "actives#index", as: "actives"
      get "/deactive", to: "deactives#index", as: "deactives"
    end

    namespace :rentals do
      get "/active", to: "actives#index", as: "actives"
      get "/deactive", to: "deactives#index", as: "deactives"
    end

    namespace :users do
      get "/active", to: "actives#index", as: "actives"
      get "/deactive", to: "deactives#index", as: "deactives"
    end

    resources :bookings, only: [:index] do
      resources :approvals, only: [:create], controller: "bookings/approvals"
      resources :cancellations, only: [:create], controller: "bookings/cancellations"
      resources :payments, only: [:create], controller: "bookings/payments"
      resources :rejections, only: [:create], controller: "bookings/rejections"
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

  namespace :rentals do
    get "/search", to: "searches#show", as: "search"
  end

  resources :booking_requests, only: [:show]

  resources :rentals, only: [:show] do
    resources :booking_requests, only: [:new, :create]
  end
end
