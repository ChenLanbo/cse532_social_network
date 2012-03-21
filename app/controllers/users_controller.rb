class UsersController < ApplicationController
	skip_before_filter :authorize, :only => [:new, :create]
  # GET /users
  # GET /users.json
  def index
		fn = params[:first_name]
		ln = params[:last_name]

		if fn and fn.length > 0 and ln.length > 0
			# @users = User.where("first_name = '#{fn}' and last_name = '#{ln}'")
			@users = User.find_by_sql("SELECT * from users WHERE id != (#{session[:user_id]}) AND id NOT IN (SELECT fu_id from friends WHERE user_id = #{session[:user_id]}) and id not in (SELECT user_id FROM friend_requests WHERE requester_id = #{session[:user_id]}) AND first_name = '#{fn}' AND last_name = '#{ln}'")
		elsif fn and fn.length > 0 and ln.length == 0
			# @users = User.where("first_name = '#{fn}'")
			@users = User.find_by_sql("SELECT * from users WHERE id != (#{session[:user_id]}) AND id not in (SELECT fu_id from friends WHERE user_id = #{session[:user_id]}) and id not in (SELECT user_id FROM friend_requests WHERE requester_id = #{session[:user_id]}) AND first_name = '#{fn}'")
		elsif fn and fn.length == 0 and ln.length > 0
			# @users = User.where("last_name = '#{ln}'")
			@users = User.find_by_sql("SELECT * from users WHERE id != (#{session[:user_id]}) AND id NOT IN (SELECT fu_id from friends WHERE user_id = #{session[:user_id]}) and id not in (SELECT user_id FROM friend_requests WHERE requester_id = #{session[:user_id]}) AND last_name = '#{ln}'")
		else
			@users = User.find_by_sql("SELECT * from users WHERE id != (#{session[:user_id]}) AND id NOT IN (SELECT fu_id from friends WHERE user_id = #{session[:user_id]}) and id not in (SELECT user_id FROM friend_requests WHERE requester_id = #{session[:user_id]})")
		end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
		@preference = Preference.new
		@preferences = Preference.find_by_sql("SELECT * FROM preferences WHERE user_id = #{session[:user_id]}")
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
		if params[:id] != session[:user_id]
			redirect_to "/users/#{session[:user_id]}"
		end
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
				#format.html { redirect_to @user, :notice => 'User was successfully created.' }
				Page.create(:category => 'user', :owner => @user.id)
				format.html { redirect_to login_url, :notice => 'Now you can login' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
end
