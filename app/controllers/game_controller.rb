class GameController < ApplicationController
  before_filter :authenticate_user!
  before_filter :must_consent

  def player
    authorize! :read, :game
  end

  def iat
  end
end
