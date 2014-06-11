class ConsentController < ApplicationController
  before_filter :login_required
  skip_authorization_check
  def form
  end

  def consent
    @user = current_user
    @user.consented = true
    if @user.save!
      redirect_to return_path
    else
      redirect_to root_url
    end
  end
end
