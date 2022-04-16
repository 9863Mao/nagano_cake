Rails.application.routes.draw do
  root to: "public/homes#top"
  
  namespace :admin do
    get 'homes/top'
    resources :items, only: [:new, :index, :create, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :create, :update]
  end
  
  namespace :public do
    get 'homes/top'
    get 'homes/about'
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
