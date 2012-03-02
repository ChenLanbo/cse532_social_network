class CirclesController < ApplicationController
  # GET /circles
  # GET /circles.json
  def index
    @circles = Circle.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @circles }
    end
  end

  # GET /circles/1
  # GET /circles/1.json
  def show
    @circle = Circle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @circle }
    end
  end

  # GET /circles/new
  # GET /circles/new.json
  def new
    @circle = Circle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @circle }
    end
  end

  # GET /circles/1/edit
  def edit
    @circle = Circle.find(params[:id])
  end

  # POST /circles
  # POST /circles.json
  def create
    @circle = Circle.new(params[:circle])

    respond_to do |format|
      if @circle.save
        format.html { redirect_to @circle, :notice => 'Circle was successfully created.' }
        format.json { render :json => @circle, :status => :created, :location => @circle }
      else
        format.html { render :action => "new" }
        format.json { render :json => @circle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /circles/1
  # PUT /circles/1.json
  def update
    @circle = Circle.find(params[:id])

    respond_to do |format|
      if @circle.update_attributes(params[:circle])
        format.html { redirect_to @circle, :notice => 'Circle was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @circle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /circles/1
  # DELETE /circles/1.json
  def destroy
    @circle = Circle.find(params[:id])
    @circle.destroy

    respond_to do |format|
      format.html { redirect_to circles_url }
      format.json { head :ok }
    end
  end
end
