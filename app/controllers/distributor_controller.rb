class DistributorController < ApplicationController
  before_filter :authenticate_user!
  before_filter :must_consent

  def index
  end

  private

  def must_consent
    unless current_user.consented?
      redirect_to consent_form_url
    end
  end
end
