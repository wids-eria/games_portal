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

  def forum
    @guild =  Guild.find(params[:guild_id])

    #Get Category for guild
    @category = Forem::Category.find_by_name(@guild.id)
  end

  def join
    if params[:join]
      @code = params[:join][:code]

      @guild = Guild.find_by_code(@code)
      if @guild
        flash[:notice] = "Joined Guild #{@guild.name}!"
        redirect_to guilds_path
      else
        params[:join].errors.add(:name, "wasn't filled in")
        render :join
      end
    else
      render :join
    end
  end
end
