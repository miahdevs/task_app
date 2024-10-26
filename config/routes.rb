Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "pages#index"

  namespace :dashboard do
    get '/', to: 'home#index', as: :root  # Dashboard home
    resources :projects do
      resources :tasks
    end
    resources :categories
  end
end
