PathfinderDistributor::Application.routes.draw do
  devise_for :users

  get "distributor/index"
  get "consent/form"
  get "game" => "game#player"
  get 'iat' => "game#iat"
  put "consent/consent"

  get 'auth/:provider/callback' => 'session#from_oauth'
  get 'auth/failure' => 'session#failure'

  get 'users/new_user' => 'session#create'

  get 'login' => 'session#login'
  delete 'logout' => 'session#destroy'

  root :to => "distributor#index"

end
