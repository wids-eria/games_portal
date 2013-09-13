class GameController < ApplicationController
  #before_filter :authenticate_user!
  before_filter :present_login
  before_filter :must_consent
  before_filter :iat_required, except: [:iat]

  def player
    authorize! :read, :game
  end

  def iat
    render  :text=>"IAT MAGIC!"
  end
end
