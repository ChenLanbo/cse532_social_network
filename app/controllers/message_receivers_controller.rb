class MessageReceiversController < ApplicationController
  # GET /message_receivers
  # GET /message_receivers.json
  def index
    @message_receivers = MessageReceiver.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @message_receivers }
    end
  end

  # GET /message_receivers/1
  # GET /message_receivers/1.json
  def show
    @message_receiver = MessageReceiver.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @message_receiver }
    end
  end

  # GET /message_receivers/new
  # GET /message_receivers/new.json
  def new
    @message_receiver = MessageReceiver.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @message_receiver }
    end
  end

  # GET /message_receivers/1/edit
  def edit
    @message_receiver = MessageReceiver.find(params[:id])
  end

  # POST /message_receivers
  # POST /message_receivers.json
  def create
    @message_receiver = MessageReceiver.new(params[:message_receiver])

    respond_to do |format|
      if @message_receiver.save
        format.html { redirect_to @message_receiver, :notice => 'Message receiver was successfully created.' }
        format.json { render :json => @message_receiver, :status => :created, :location => @message_receiver }
      else
        format.html { render :action => "new" }
        format.json { render :json => @message_receiver.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /message_receivers/1
  # PUT /message_receivers/1.json
  def update
    @message_receiver = MessageReceiver.find(params[:id])

    respond_to do |format|
      if @message_receiver.update_attributes(params[:message_receiver])
        format.html { redirect_to @message_receiver, :notice => 'Message receiver was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @message_receiver.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /message_receivers/1
  # DELETE /message_receivers/1.json
  def destroy
    @message_receiver = MessageReceiver.find(params[:id])
    @message_receiver.destroy

    respond_to do |format|
      format.html { redirect_to message_receivers_url }
      format.json { head :ok }
    end
  end
end
