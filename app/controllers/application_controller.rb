class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    if session[:current_user].nil?
      session[:current_user] = User.find_by_ada_id(session[:ada_id])
    end
    return session[:current_user]
  end

  def guest
    return current_user.guest
  end

  def present_login
    unless current_user
      set_return(request.url)
      redirect_to new_user_session_path
    end
  end

  def login_required
    if !current_user
      respond_to do |format|
        session[:type] = request.query_parameters['type']
        format.html  {
          redirect_to '/auth/ada'
        }
        format.json {
          render :json => { 'error' => 'Access Denied' }.to_json
        }
      end
    end
  end

  def return_path
    session[:return_path] ? session[:return_path] : root_path
  end

  def set_return(path)
    session[:return_path] = path
  end
  private

  def must_consent
    unless current_user.consented?
      set_return(request.url)
      redirect_to consent_form_url
    end
  end
end
