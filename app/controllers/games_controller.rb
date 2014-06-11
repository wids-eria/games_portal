class GamesController < ApplicationController
authorize_resource
  skip_authorize_resource :game, :find_by => :path, only: [:landing,:player]
  skip_authorize_resource :game, :find_by => :id, only: [:landing,:player]
  before_filter :login_required, only: [:show]
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
      #flash[:notice] = root_url
      path  = "#{root_url}static_games/"+@game.localpath
      @file = "<embed id='game_embed' width='100%' height='100%' src=#{path} allowscriptaccess='sameDomain' />"
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
      flash[:notice] = @game.errors.messages
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
    @game.build_survey
    @game.attachments.build
  end

  def new
    @game = Game.new
    @game.build_survey
    @game.attachments.build
  end

  def index
    @game = Game.all

  end

  def destroy
    Game.find_by_path(params[:id]).destroy
    redirect_to root_url
  end
end