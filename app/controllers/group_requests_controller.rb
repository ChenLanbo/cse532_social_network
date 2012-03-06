class GroupRequestsController < ApplicationController
  # GET /group_requests
  # GET /group_requests.json
  def index
    @group_requests = GroupRequest.all

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
    @group_request = GroupRequest.new(params[:group_request])

    respond_to do |format|
      if @group_request.save
        format.html { redirect_to @group_request, :notice => 'Group request was successfully created.' }
        format.json { render :json => @group_request, :status => :created, :location => @group_request }
      else
        format.html { render :action => "new" }
        format.json { render :json => @group_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /group_requests/1
  # PUT /group_requests/1.json
  def update
    @group_request = GroupRequest.find(params[:id])

    respond_to do |format|
      if @group_request.update_attributes(params[:group_request])
        format.html { redirect_to @group_request, :notice => 'Group request was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @group_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /group_requests/1
  # DELETE /group_requests/1.json
  def destroy
    @group_request = GroupRequest.find(params[:id])
    @group_request.destroy

    respond_to do |format|
      format.html { redirect_to group_requests_url }
      format.json { head :ok }
    end
  end
end
