class GameController < ApplicationController
  before_filter :authenticate_user!
  before_filter :must_consent

  def player
  end
end
