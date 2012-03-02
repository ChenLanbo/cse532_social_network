class CircleMembersController < ApplicationController
  # GET /circle_members
  # GET /circle_members.json
  def index
    @circle_members = CircleMember.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @circle_members }
    end
  end

  # GET /circle_members/1
  # GET /circle_members/1.json
  def show
    @circle_member = CircleMember.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @circle_member }
    end
  end

  # GET /circle_members/new
  # GET /circle_members/new.json
  def new
    @circle_member = CircleMember.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @circle_member }
    end
  end

  # GET /circle_members/1/edit
  def edit
    @circle_member = CircleMember.find(params[:id])
  end

  # POST /circle_members
  # POST /circle_members.json
  def create
    @circle_member = CircleMember.new(params[:circle_member])

    respond_to do |format|
      if @circle_member.save
        format.html { redirect_to @circle_member, :notice => 'Circle member was successfully created.' }
        format.json { render :json => @circle_member, :status => :created, :location => @circle_member }
      else
        format.html { render :action => "new" }
        format.json { render :json => @circle_member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /circle_members/1
  # PUT /circle_members/1.json
  def update
    @circle_member = CircleMember.find(params[:id])

    respond_to do |format|
      if @circle_member.update_attributes(params[:circle_member])
        format.html { redirect_to @circle_member, :notice => 'Circle member was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @circle_member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /circle_members/1
  # DELETE /circle_members/1.json
  def destroy
    @circle_member = CircleMember.find(params[:id])
    @circle_member.destroy

    respond_to do |format|
      format.html { redirect_to circle_members_url }
      format.json { head :ok }
    end
  end
end
