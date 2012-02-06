PathfinderDistributor::Application.routes.draw do
  devise_for :users

  get "distributor/index"
  get "consent/form"
  put "consent/consent"

  root :to => "distributor#index"
end
