class CircleMembersController < ApplicationController
  # GET /circle_members
  # GET /circle_members.json
  def index
    @circle_members = CircleMember.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @circle_members }
    end
  end

  # GET /circle_members/1
  # GET /circle_members/1.json
  def show
    @circle_member = CircleMember.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @circle_member }
    end
  end

  # GET /circle_members/new
  # GET /circle_members/new.json
  def new
    @circle_member = CircleMember.new

		@friends = Friend.find_by_sql("SELECT friends.*, users.first_name, users.last_name FROM friends, users WHERE friends.user_id = #{session[:user_id]} AND friends.fu_id = users.id AND users.id NOT IN (SELECT user_id FROM circle_members WHERE circle_id = #{params[:circle_id]})");
		@circle_id = params[:circle_id]
		puts "++++++++++++++++++ " + params[:circle_id].to_s
		puts "++++++++++++++++++ " + @friends.length.to_s

    respond_to do |format|
      format.html # new.html.erb
			format.js
      format.json { render :json => @circle_member }
    end
  end

  # GET /circle_members/1/edit
  def edit
    @circle_member = CircleMember.find(params[:id])
  end

  # POST /circle_members
  # POST /circle_members.json
  def create
    @circle_member = CircleMember.new
		@circle_member.circle_id = params[:circle_id]
		@circle_member.user_id = params[:user_id]

    respond_to do |format|
      if @circle_member.save

				@circle_member.instance_eval("def last_name; return @last_name; end")
				@circle_member.instance_eval("def last_name=(value); @last_name = value; end")
				@circle_member.instance_eval("def first_name; return @first_name; end")
				@circle_member.instance_eval("def first_name=(value); @first_name = value; end")
				@circle_member.last_name = params[:last_name]
				@circle_member.first_name = params[:first_name]

				# format.html { redirect_to @circle_member, :notice => 'Circle member was successfully created.' }
				format.html { redirect_to "/circles/#{params[:circle_id]}"}
				format.js
        format.json { render :json => @circle_member, :status => :created, :location => @circle_member }
      else
        format.html { render :action => "new" }
        format.json { render :json => @circle_member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /circle_members/1
  # PUT /circle_members/1.json
  def update
    @circle_member = CircleMember.find(params[:id])

    respond_to do |format|
      if @circle_member.update_attributes(params[:circle_member])
        format.html { redirect_to @circle_member, :notice => 'Circle member was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @circle_member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /circle_members/1
  # DELETE /circle_members/1.json
  def destroy
    @circle_member = CircleMember.find(params[:id])
		circle_id = @circle_member.circle_id
    @circle_member.destroy

    respond_to do |format|
      format.html { redirect_to "/circles/#{circle_id}" }
      format.json { head :ok }
    end
  end
end
