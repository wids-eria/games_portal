GlsPortal::Application.routes.draw do
  resources :groups do
    member do
      put :add_user
    end
    collection do
      get "classes" => "groups#classes"
    end
  end

  devise_for :users
  resources :games do
    member do
      get "survey" => "survey#show"
      get "play" => "games#show"
    end
  end

  get "portal/index"
  get "games" => "portal#index"
  get "consent/form"

  get "/game/:id" =>"games#landing", as: "game_landing"

  put "consent/consent"

  get '*/auth/:provider/callback' => 'session#from_oauth'
  get 'auth/failure' => 'session#failure'
  get 'users/new_user' => 'session#create'


  get 'profile/:name', to:'user#show', as: "profile"

  get 'login' => 'session#login'
  get 'guest' => 'session#create_guest'
  delete 'logout' => 'session#destroy'

  root :to => "portal#index"
end