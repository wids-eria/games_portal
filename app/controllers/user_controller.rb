class UserController < ApplicationController
  before_filter :login_required, except: [:howto]
  before_filter :must_consent, except: [:howto]
  skip_authorization_check

  def show
    unless params[:name].empty?
      @user = User.find_by_player_name(params[:name])
      if @user.nil?
        #attempt to create new User from adage
        adage = User.on_db(:adage).find_by_player_name(params[:name])
        unless adage.nil?
         @user  = User.create_from_adage(adage)
        end
      end

      unless current_user.can_view_user(@user)
        flash[:error] = "You do not have permission to view user #{@user.player_name}'s profile"
        redirect_to profile_url(name: current_user.player_name)
      end
    else
      @user = current_user
    end

    @games = Game.all
  end

  def howto
  end

  def curricula
  end
end