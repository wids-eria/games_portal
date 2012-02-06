class ConsentController < ApplicationController
  before_filter :authenticate_user!

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
