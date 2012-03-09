class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.find_by_sql("SELECT messages.*, users.first_name, users.last_name FROM messages, message_receivers, users WHERE messages.id = message_receivers.message_id AND message_receivers.user_id = #{session[:user_id]} AND users.id = messages.user_id")

    respond_to do |format|
      format.html # index.html.erb
			format.js
      format.json { render :json => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find_by_sql("SELECT messages.*, users.first_name, users.last_name FROM messages, message_receivers, users WHERE messages.id = #{params[:id]} AND messages.id = message_receivers.message_id AND message_receivers.user_id = #{session[:user_id]} AND users.id = messages.user_id")[0]

    respond_to do |format|
      format.html # show.html.erb
			format.js
      format.json { render :json => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
			format.js
      format.json { render :json => @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(params[:message])
		@message.user_id = session[:user_id]

		puts session[:receivers]

    respond_to do |format|
      if @message.save

				session[:receivers].each do |r|
					MessageReceiver.create(:message_id => @message.id, :user_id => r)
				end

        format.html { redirect_to messages_url, :notice => 'Message was successfully created.' }
        format.json { render :json => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.json { render :json => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, :notice => 'Message was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :ok }
    end
  end

end
