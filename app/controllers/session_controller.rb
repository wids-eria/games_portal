class SessionController < ApplicationController
  skip_authorization_check
  before_filter :login_required, except: [:from_oauth, :destroy, :create]

  def from_oauth
    omniauth = env['omniauth.auth']

    unless omniauth.nil?
      session[:token] = omniauth['credentials']['token']
      session[:player_name] = omniauth['extra']['raw_info']['info']['player_name']

      @auth = omniauth
      @token = session[:token]
    end

    redirect_to root_url
  end

  def login
    redirect_to root_url
  end

  def destroy
    reset_session
    #@todo update flash
    #flash[:notice] = %Q[You have been logged out of Fairplay but are still logged into your <a href="http://ada.production.eriainteractive.com">GLS account.</a>].html_safe

    redirect_to root_url
  end

  def create
    json_body = {user: {login: params[:login], password: params[:password]}}
    auth_response = HTTParty.post("http://ada.production.eriainteractive.com/users/sign_in.json", body: json_body)

    if auth_response.code == 201
      session[:token] = auth_response['authentication_token']
      session[:player_name] = auth_response['player_name']
    else
      #@todo redirect to failure page
    end
    redirect_to root_url

  end
end