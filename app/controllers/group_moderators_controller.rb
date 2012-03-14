class GroupModeratorsController < ApplicationController
  # GET /group_moderators
  # GET /group_moderators.json
  def index
    @group_moderators = GroupModerator.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @group_moderators }
    end
  end

  # GET /group_moderators/1
  # GET /group_moderators/1.json
  def show
    @group_moderator = GroupModerator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @group_moderator }
    end
  end

  # GET /group_moderators/new
  # GET /group_moderators/new.json
  def new
    @group_moderator = GroupModerator.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @group_moderator }
    end
  end

  # GET /group_moderators/1/edit
  def edit
    @group_moderator = GroupModerator.find(params[:id])
  end

  # POST /group_moderators
  # POST /group_moderators.json
  def create
    @group_moderator = GroupModerator.new(params[:group_moderator])

    respond_to do |format|
      if @group_moderator.save
        format.html { redirect_to @group_moderator, :notice => 'Group moderator was successfully created.' }
        format.json { render :json => @group_moderator, :status => :created, :location => @group_moderator }
      else
        format.html { render :action => "new" }
        format.json { render :json => @group_moderator.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /group_moderators/1
  # PUT /group_moderators/1.json
  def update
    @group_moderator = GroupModerator.find(params[:id])

    respond_to do |format|
      if @group_moderator.update_attributes(params[:group_moderator])
        format.html { redirect_to @group_moderator, :notice => 'Group moderator was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @group_moderator.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /group_moderators/1
  # DELETE /group_moderators/1.json
  def destroy
    @group_moderator = GroupModerator.find(params[:id])
    @group_moderator.destroy

    respond_to do |format|
      format.html { redirect_to group_moderators_url }
      format.json { head :ok }
    end
  end
end
