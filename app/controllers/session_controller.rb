class SessionController < ApplicationController
  skip_authorization_check
  before_filter :login_required, except: [:from_oauth, :destroy, :create_guest, :testpost]

  def from_oauth
    omniauth = env['omniauth.auth']

    unless omniauth.nil?
      session[:token] = omniauth['credentials']['token']
      session[:player_name] = omniauth['extra']['raw_info']['info']['player_name']
      session[:ada_id] = omniauth['uid']

      User.create_from_session(session)
    end

    redirect_to root_url
  end

  def login
    redirect_to root_url
  end

  def destroy
    reset_session

    flash[:notice] = %Q[You have been logged out of the GLS Portal but are still logged into your <a href="http://ada.production.eriainteractive.com">GLS account.</a>].html_safe
    redirect_to new_user_session_path
  end

  def failure
    render :text => params[:message]
  end

  def create_guest
    body = {
      client_id: "foo",
      client_secret: "bar",
    }

    auth_response = HTTParty.post("http://localhost:3000/auth/ada/guest.json", body: body)

    if auth_response.code == 200
      session[:token] = auth_response['info']['token']
      session[:guest] = auth_response['info']['guest']
      session[:ada_id] = auth_response['uid']
      session[:player_name] = "Guest"

      User.create_from_session(session)
    end
    redirect_to root_url
  end

  def create
    json_body = {user: {login: params[:login], password: params[:password]}}
    #auth_response = HTTParty.post("http://ada.production.eriainteractive.com/users/sign_in.json", body: json_body)
    #auth_response = HTTParty.post("http://ada.production.eriainteractive.com/auth/ada/user.json", body: json_body)

    if auth_response.code == 201
      session[:token] = auth_response['authentication_token']
      session[:player_name] = auth_response['player_name']
    else
      #@todo redirect to failure page
    end
 #   redirect_to root_url

  end
end