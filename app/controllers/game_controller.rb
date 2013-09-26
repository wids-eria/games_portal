class GameController < ApplicationController
  #before_filter :authenticate_user!
  before_filter :present_login
  before_filter :must_consent

  def player
    authorize! :read, :game
  end

  def show
    @game =  Game.find_by_path(params[:game])
    if @game.nil?
      flash[:error] = "Game not found for "+params[:game]+"!"
      redirect_to root_url
    end
  end

  def index
    @games = Game.all
  end
end
