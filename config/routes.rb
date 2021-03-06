Rails.application.routes.draw do
  devise_for :accounts
  resources :contracts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "public#index"

  get "join/:contract_id" => "contracts#join"
  get "me" => "public#me"
end
