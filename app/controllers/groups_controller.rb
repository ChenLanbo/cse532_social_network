class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.find_by_sql("SELECT * from groups WHERE user_id = #{session[:user_id]} or id in (SELECT group_id FROM group_members WHERE user_id = #{session[:user_id]})")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])
		@page = Page.find_by_sql("SELECT * FROM pages WHERE category = 'group' AND owner = #{@group.id}")[0]
    respond_to do |format|
			format.html { redirect_to "/pages/#{@page.id}" }
      format.json { render :json => @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(params[:group])
		@group.user_id = session[:user_id]
    respond_to do |format|
      if @group.save

				@page = Page.create(:owner => @group.id, :category => 'group')
        format.html { redirect_to groups_url, :notice => 'Group was successfully created.' }
        format.json { render :json => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.json { render :json => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, :notice => 'Group was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
		@pages = Page.where(:category => 'group', :owner => @group.id)
		@pages.each do |p|
			p.destroy
		end
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :ok }
    end
  end

	# GET /groupsearch
	def search
		@groups = Group.find_by_sql("SELECT * from groups WHERE user_id != '#{session[:user_id]}' AND id NOT IN (SELECT group_id FROM group_members WHERE user_id = #{session[:user_id]})")
		render
	end
end
