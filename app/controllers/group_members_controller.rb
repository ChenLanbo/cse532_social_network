class GroupMembersController < ApplicationController
  # GET /group_members
  # GET /group_members.json
  def index
    @group_members = GroupMember.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @group_members }
    end
  end

  # GET /group_members/1
  # GET /group_members/1.json
  def show
    @group_member = GroupMember.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @group_member }
    end
  end

  # GET /group_members/new
  # GET /group_members/new.json
  def new
    @group_member = GroupMember.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @group_member }
    end
  end

  # GET /group_members/1/edit
  def edit
    @group_member = GroupMember.find(params[:id])
  end

  # POST /group_members
  # POST /group_members.json
  def create
    @group_member = GroupMember.new(params[:group_member])

    respond_to do |format|
      if @group_member.save
        format.html { redirect_to @group_member, :notice => 'Group member was successfully created.' }
        format.json { render :json => @group_member, :status => :created, :location => @group_member }
      else
        format.html { render :action => "new" }
        format.json { render :json => @group_member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /group_members/1
  # PUT /group_members/1.json
  def update
    @group_member = GroupMember.find(params[:id])

    respond_to do |format|
			if @group_member.moderator == true
      	@group_member.update_attributes(:moderator => false)
			else
      	@group_member.update_attributes(:moderator => true)
			end

			format.js
    end
  end

  # DELETE /group_members/1
  # DELETE /group_members/1.json
  def destroy
    @group_member = GroupMember.find(params[:id])
    @group_member.destroy

    respond_to do |format|
      format.html { redirect_to group_members_url }
			format.js
      format.json { head :ok }
    end
  end
end
