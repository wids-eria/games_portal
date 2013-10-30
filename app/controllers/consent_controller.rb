class ConsentController < ApplicationController
  before_filter :present_login

  def form
  end

  def consent
    # set
    # redirect
    @user = current_user
    @user.consented = true
    @user.save!
    redirect_to root_url
  end
end
