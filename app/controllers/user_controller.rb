class UserController < ApplicationController
  before_filter :present_login
  before_filter :must_consent

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
    else
      @user = current_user
    end
    @games = Game.all
  end

end