Rails.application.routes.draw do
  resources :profissionais
  resources :exames
  resources :consultas
  get "endereco/index"
  get "endereco/show"
  get "endereco/new"
  get "endereco/edit"
  get "endereco/create"
  get "endereco/update"
  get "endereco/destroy"
  resources :pacientes
  resources :endereco

  # Define a view principal (home)
  root "pacientes#index"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # API v1
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'info', to: 'info#index'
    end
  end
end
