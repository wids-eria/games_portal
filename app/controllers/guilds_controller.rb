class GuildsController < ApplicationController
  def new
    @guild =  Guild.new
  end

  def create
    @guild = Guild.new(params[:guild])
    if @guild.save
      GuildOwnership.create(user: current_user,guild: @guild)
      GuildUser.create(user: current_user,guild: @guild)

      flash[:notice] = 'Guild Created'
      redirect_to guilds_path
    else
      render :new
    end
  end

  def update
    @guild =  Guild.find(params[:id])
    if @guild.update_attributes params[:guild]
      flash[:notice] = 'Guild Updated'
      redirect_to guilds_path
    else
      render :edit
    end
  end

  def edit
    @guild =  Guild.find(params[:id])
  end

  def destroy
    guild = Guild.find(params[:id])
    GuildUser.destroy_all(guild_id: guild.id)
    GuildOwnership.destroy_all(guild_id: guild.id)
    guild.destroy

    flash[:notice] = 'Guild Updated'
    redirect_to guilds_path
  end

  def index
    @guilds =  User.find(session[:id]).owned_guilds

  end

  def show
    @guild =  Guild.find(params[:id])
  end
end
