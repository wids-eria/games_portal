class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_account
    return session[:token] unless session[:token].nil?
  end

  def login_required
    if !current_account
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
