Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :vaccines, only: [:create]
  resources :patients, only: [:create, :destroy] do
    get 'vaccine_card', to: 'patients#vaccine_card_informations', on: :member
  end

  resources :vaccinate, only: [:create]
end
