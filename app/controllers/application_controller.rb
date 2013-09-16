class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    if session[:current_user].nil?
      session[:current_user] = User.find_by_ada_id(session[:ada_id])
    end
    return session[:current_user]
  end

  def present_login
    unless current_user
      redirect_to new_user_session_path
    end
  end

  def iat_required
    #@todo find a way to abstract this so its not stupid
    user_id  = session[:ada_id]
    count = AdaData.where({gameName: 'FairPlay',user_id: user_id, key: 'IATFinalBias'}).count()
    if count == 0
      redirect_to iat_url
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
  private

  def must_consent
    unless current_user.consented?
      redirect_to consent_form_url
    end
  end
end
