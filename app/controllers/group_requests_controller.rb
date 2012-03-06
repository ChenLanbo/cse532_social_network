class GroupRequestsController < ApplicationController
  # GET /group_requests
  # GET /group_requests.json
  def index

		if params[:group_id] == nil
    	@group_requests = []
		else
			@group_requests = GroupRequest.find_by_sql("SELECT group_requests.*, users.first_name, users.last_name FROM group_requests, users WHERE group_requests.group_id = #{params[:group_id]} AND group_requests.user_id = users.id")
		end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @group_requests }
    end
  end

  # GET /group_requests/1
  # GET /group_requests/1.json
  def show
    @group_request = GroupRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @group_request }
    end
  end

  # GET /group_requests/new
  # GET /group_requests/new.json
  def new
    @group_request = GroupRequest.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @group_request }
    end
  end

  # GET /group_requests/1/edit
  def edit
    @group_request = GroupRequest.find(params[:id])
  end

  # POST /group_requests
  # POST /group_requests.json
  def create

    respond_to do |format|
			if GroupRequest.where("group_id = #{params[:group_id]} and user_id = #{session[:user_id]}").length == 0
				@group_request = GroupRequest.new(:group_id => params[:group_id], :user_id => session[:user_id])
      	if @group_request.save
        	format.html { redirect_to '/groupsearch', :notice => 'Group request was successfully created.' }
					format.js
        	format.json { render :json => @group_request, :status => :created, :location => @group_request }
      	else
        	format.html { redirect_to '/groupsearch' } 
					format.json { render :json => @group_request.errors, :status => :unprocessable_entity }
      	end
			else
				format.html { redirect_to '/groupsearch'}
			end
    end
  end

  # PUT /group_requests/1
  # PUT /group_requests/1.json
  def update
    @group_request = GroupRequest.find(params[:id])

		respond_to do |format|
			@group_member = GroupMember.create(:group_id => @group_request.group_id, :user_id => @group_request.user_id)
			@group_request.destroy
			format.html { redirect_to "/group_requests?group_id=#{@group_member.group_id}"}
			format.js
		end

  end

  # DELETE /group_requests/1
  # DELETE /group_requests/1.json
  def destroy
    @group_request = GroupRequest.find(params[:id])
    @group_request.destroy

    respond_to do |format|
      format.html { redirect_to group_requests_url }
			format.js
      format.json { head :ok }
    end
  end
end
