class GamesController < ApplicationController
  load_and_authorize_resource :game, :find_by => :path, only: [:landing]
  load_and_authorize_resource :game, :find_by => :id, only: [:landing]
  before_filter :present_login, only: [:show]
  before_filter :must_consent, only: [:show]

  def player
    authorize! :read, :game
  end

  def landing
    @game =  Game.find_by_path(params[:id])
  end

  def show
    @game =  Game.find_by_path(params[:id])

    unless @game.localpath.empty?
      #Rails Fix to render a static file correctly
      flash[:notice] = root_url

      @file = File.open("./#{root_path}public/static_games/"+@game.localpath).read
    end
    if @game.nil?
      flash[:error] = "Game not found for "+params[:id]+"!"
      redirect_to root_url
    end
  end

  def create
    @game = Game.new(params[:game])
    if @game.save
      redirect_to root_url
    else
      render :new
    end
  end

  def update
    @game =  Game.find(params[:id])

    if @game.update_attributes params[:game]
      redirect_to root_url
    else
      render :edit
    end
  end

  def edit
    @game =  Game.find_by_path(params[:id])
  end

  def new
    @game = Game.new
    @game.build_survey
  end

  def index
    @game = Game.all
  end

  def destroy
    Game.find_by_path(params[:id]).destroy
    redirect_to root_url
  end
end