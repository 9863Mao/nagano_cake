Rails.application.routes.draw do

  namespace :public do
    get 'homes/top'
    get 'homes/about'
    get 'customers/my_page'
    get 'customers/confirm'
    get 'customers/edit'
    patch 'customers' => 'customers#update'
    patch 'customers/unsubscribe'
    resources :cart_items, only: [:index, :update, :destroy, :create]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :items, only: [:index, :show]

  end

  root to: "public/homes#top"

  namespace :admin do
    get 'orders/show'
    get 'homes/top'
    resources :items, only: [:new, :index, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :create, :update]
  end

  devise_for :admin,skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


  devise_for :customers,skip: [:passwords] ,controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
