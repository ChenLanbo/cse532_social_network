class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
		respond_to do |format|
			format.html
		end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
		# puts "+++++++++++++++++ " + @post.page_id.to_s
		@post.user_id = session[:user_id]
		@comment = Comment.new
    respond_to do |format|
      if @post.save

				@post.instance_eval("def last_name; return @last_name; end")
				@post.instance_eval("def last_name=(value); @last_name = value; end")
				@post.instance_eval("def first_name; return @first_name; end")
				@post.instance_eval("def first_name=(value); @first_name = value; end")
				@post.last_name = current_user.last_name
				@post.first_name = current_user.first_name

        format.html { redirect_to @post, :notice => 'Post was successfully created.' }
				format.js
        format.json { render :json => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, :notice => 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
			format.js
    end
  end
end
