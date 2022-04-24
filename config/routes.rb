Rails.application.routes.draw do

  namespace :public do
    get 'address/index'
    get 'address/edit'
  end
  namespace :public do
    get 'items/index'
    get 'items/show'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
    patch 'customers/unsubscribe'
    resources :customers, only: [:edit, :update]
    get 'customers/my_page'
    get 'customers/confirm'
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
