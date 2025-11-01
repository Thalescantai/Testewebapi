Rails.application.routes.draw do
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/esqueci-minha-senha", to: "passwords#new", as: :forgot_password
  post "/esqueci-minha-senha", to: "passwords#create"

  resources :profissionais
  resources :exames do
    member do
      get :realizar
      patch :concluir_realizacao
      get :remarcar
    end
  end
  get "consultas/:consulta_id/exames", to: "exames#por_consulta", as: :consulta_exames
  resources :materiais, only: :index
  get "consultas/:consulta_id/materiais", to: "materiais#por_consulta", as: :consulta_materiais
  resources :consultas do
    member do
      patch :checkin
      get :iniciar_atendimento
    end
    get :medico, on: :collection
  end
  resources :pacientes
  resources :enderecos, controller: :endereco

  # Define a view principal (home)
  root "consultas#index"

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
