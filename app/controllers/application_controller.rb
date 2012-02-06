class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def must_consent
    unless current_user.consented?
      redirect_to consent_form_url
    end
  end
end
