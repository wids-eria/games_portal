GlsPortal::Application.routes.draw do
  devise_for :users

  get "portal/index"
  get "consent/form"
  get "/game/:game" =>"game#landing", as: "game_landing"
  get "/play/:game" =>"game#show", as: "play"
  get "games" => "portal#index"

  put "consent/consent"

  get 'auth/:provider/callback' => 'session#from_oauth'
  get 'auth/failure' => 'session#failure'
  get 'users/new_user' => 'session#create'

  get 'login' => 'session#login'
  get 'guest' => 'session#create_guest'
  delete 'logout' => 'session#destroy'

  root :to => "portal#index"
end