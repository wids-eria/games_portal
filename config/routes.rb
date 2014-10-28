GlsPortal::Application.routes.draw do

  # This line mounts Forem's routes at /forums by default.
  # This means, any requests to the /forums URL of your application will go to Forem::ForumsController#index.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Forem relies on it being the default of "forem"
  mount Forem::Engine, :at => '/forums'

  get 'forum' => 'forem/forums#index'
  resources :guilds do
  end

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

  get 'auth/:provider/callback' => 'session#from_oauth'
  get 'auth/failure' => 'session#failure'
  get 'users/new_user' => 'session#create'


  get 'profile/:name', to:'user#show', as: "profile", :constraints => { :name => /[\w+\.+\ +\%]+/ }

  get 'login' => 'session#login'
  get 'guest' => 'session#create_guest'
  delete 'logout' => 'session#destroy'

  root :to => "portal#index"
end