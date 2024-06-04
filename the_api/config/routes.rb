Rails.application.routes.draw do
  resources :comments
  devise_for :users, controllers: { 
    sessions: 'users/sessions',
    registrations: 'users/registrations'
   }
  resources :articles
  get "up" => "rails/health#show", as: :rails_health_check

  resources :articles do
    resources :comments, only: [:index, :show, :create, :update, :destroy]
  end
end
