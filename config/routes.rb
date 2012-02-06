PathfinderDistributor::Application.routes.draw do
  devise_for :users

  get "distributor/index"
  get "consent/form"
  get "game" => "game#player"
  put "consent/consent"

  root :to => "distributor#index"
end
