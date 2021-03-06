class PagesController < ApplicationController
  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find(params[:id])
		@posts = Post.find_by_sql("SELECT posts.*, users.first_name, users.last_name FROM posts, users WHERE posts.page_id = #{@page.id} AND posts.user_id = users.id ORDER BY updated_at DESC")

		# Get comments
		@posts.each do |pp|
			pp.instance_eval("def comments; @comments; end")
			pp.instance_eval("def comments=(value); @comments = value; end")
			pp.comments = Comment.find_by_sql("SELECT comments.*, users.first_name, users.last_name FROM comments, users WHERE comments.post_id = #{pp.id} AND comments.user_id = users.id")
		end

		@post = Post.new
		@comment = Comment.new

		if @page.category == 'group'
			@group = Group.find_by_id(@page.owner)
			@user = User.find_by_id(@group.user_id)
			@group_members = GroupMember.find_by_sql("SELECT group_members.*, users.first_name, users.last_name FROM group_members, users WHERE group_members.group_id = #{@page.owner} AND group_members.user_id = users.id")
		elsif @page.category == 'user'
			@user = User.find_by_id(@page.owner)
		else
		end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, :notice => 'Page was successfully created.' }
        format.json { render :json => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.json { render :json => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, :notice => 'Page was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :ok }
    end
  end
end
