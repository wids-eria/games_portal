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
      flash[:notice] = error_format(@guild.errors)
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
    @code = Code.new(params[:code])

    if params[:code]
      if @code.valid?
        @guild = Guild.find_by_code(@code.name.downcase)
        if @guild
          if GuildUser.where(user: current_user,guild: @guild).nil?
            GuildUser.create(user: current_user,guild: @guild)
          end
          flash[:notice] = "Joined Guild #{@guild.name}!"
          redirect_to guilds_path
        else
          @code.errors[" "] = "No guild found for code #{@code.name}"
          flash[:notice] = error_format(@code.errors)
          render :join
        end
      end
    else
      render :join
    end
  end
end
