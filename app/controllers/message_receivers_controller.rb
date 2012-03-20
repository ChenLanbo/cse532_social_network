class MessageReceiversController < ApplicationController
  # GET /message_receivers
  # GET /message_receivers.json
  def index
    @message_receivers = []

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
		@friends = Friend.find_by_sql("SELECT friends.*, users.first_name, users.last_name FROM friends, users WHERE friends.user_id = #{session[:user_id]} AND friends.fu_id = users.id")
		session[:receivers] = []

    respond_to do |format|
      format.html # new.html.erb
			format.js
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
    @message_receiver = MessageReceiver.new

		puts params[:name]
		puts session[:receivers]

		session[:receivers] << params[:fu].to_i

    respond_to do |format|
			format.js
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
			format.js
      format.json { head :ok }
    end
  end
end
