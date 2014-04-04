class UserController < ApplicationController
  before_filter :present_login
  before_filter :must_consent

  def show
    @user = current_user
    @games = Game.all

  end
end