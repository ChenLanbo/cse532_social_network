class FriendsController < ApplicationController
  # GET /friends
  # GET /friends.json
  def index
		@friends = Friend.find_by_sql("SELECT friends.*, users.first_name, users.last_name, pages.id AS page_id FROM friends, users, pages WHERE friends.user_id = #{session[:user_id]} AND friends.fu_id = users.id AND pages.category = 'user' AND pages.owner = users.id");

		@friends.each do |f|
			f.instance_eval("def page; @page; end")
			f.instance_eval("def page=(v); @page = v; end")
			f.page = Page.find_by_sql("SELECT * FROM pages WHERE category = 'user' AND owner = #{f.fu_id}")[0]
		end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @friends }
    end
  end

  # GET /friends/1
  # GET /friends/1.json
  def show
    @friend = Friend.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @friend }
    end
  end

  # GET /friends/new
  # GET /friends/new.json
  def new
    @friend = Friend.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @friend }
    end
  end

  # GET /friends/1/edit
  def edit
    @friend = Friend.find(params[:id])
  end

  # POST /friends
  # POST /friends.json
  def create
    @friend = Friend.new(params[:friend])

    respond_to do |format|
      if @friend.save
        format.html { redirect_to @friend, :notice => 'Friend was successfully created.' }
        format.json { render :json => @friend, :status => :created, :location => @friend }
      else
        format.html { render :action => "new" }
        format.json { render :json => @friend.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /friends/1
  # PUT /friends/1.json
  def update
    @friend = Friend.find(params[:id])

    respond_to do |format|
      if @friend.update_attributes(params[:friend])
        format.html { redirect_to @friend, :notice => 'Friend was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @friend.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1
  # DELETE /friends/1.json
  def destroy
		@friend1 = Friend.find(params[:id])
		@friend2 = Friend.find_by_sql("SELECT * FROM friends WHERE user_id = #{@friend1.fu_id} and fu_id = #{session[:user_id]} LIMIT 1")
		@friend1.destroy
		@friend2[0].destroy if @friend2.length > 0

    respond_to do |format|
      format.html { redirect_to friends_url }
			format.js
      format.json { head :ok }
    end
  end
end
