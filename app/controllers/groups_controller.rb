class GroupsController < ApplicationController
  #load_and_authorize_resource

  def index
    @groups = Group.all
  end

  def classes
    @groups = current_user.owned_groups
  end

  def show
    @group = Group.find(params[:id])
    text = ActiveSupport::JSON.encode({ group: @group.code })
    @qr = qrcode(text)
    @users = User.select("id,player_name").order(:player_name).page(params[:page])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes params[:group]
      flash[:notice] = 'Group Updated'
      redirect_to @group
    else
      render :edit
    end
  end

  def new
    @group = Group.new(params[:group])
  end

  def create
    @group = Group.new(params[:group])

    if @group.save
      #Create ownership for the group using the adage db
      ownership = GroupOwnership.new(user_id: User.on_db(:adage).find_by_id(current_user[:id]).id,group_id: @group.id)

      if ownership.save
        flash[:notice] = 'Group Added'
        redirect_to main_app.profile_path
      else
        flash[:error] = 'Group Could Not be Created'
      end
    else
      render :new
    end
  end
end