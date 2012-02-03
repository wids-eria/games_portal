PathfinderDistributor::Application.routes.draw do
  get "users/consent"

  devise_for :users

  get "distributor/index"
  get "users/consent_form"
  put "users/consent"

  root :to => "distributor#index"
end
