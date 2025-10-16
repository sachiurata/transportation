Rails.application.routes.draw do
  # 静的ページ
  root "static_pages#top"

  # ユーザーアカウント
  resources :users, only: [ :new, :create, :show ] do
    resources :children, only: [ :new, :create, :edit, :update ]
  end
  resource :session, only: [ :new, :create, :destroy ]

  # 移動希望（リクエスト）
  resources :requested_routes, controller: "requested_routes", path: "requests" do
    resources :requested_times, only: [ :create ]
  end

  # 管理者用
  namespace :admin do
    get "login", to: "sessions#new"
    resource :session, only: [ :create, :destroy ]
    root "dashboards#top"
    get "dashboards/heatmap", to: "dashboards#heatmap"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
