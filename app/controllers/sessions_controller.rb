class SessionsController < ApplicationController
	skip_before_filter :authorize
  def new
		if session[:user_id]
			redirect_to "/pages/#{session[:page_id]}"
		end
  end

  def create
		if user = User.authenticate(params[:email], params[:password])
			# puts "------------ " + user.id.to_s
			session[:user_id] = user.id
			session[:first_name] = user.first_name
			session[:last_name] = user.last_name
			# page = Page.where("category = 'user' and owner = #{user.id}")
			page = Page.find_by_sql("SELECT * FROM pages where category = 'user' and owner = #{user.id} LIMIT 1")[0]
			session[:page_id] = page.id
			redirect_to "/pages/#{page.id}"
		else
			redirect_to login_url, :notice => "Invalid email/password combination"
		end
  end

  def destroy
		session[:user_id] = nil
		redirect_to login_url, :notice => "Logged Out"
	end

end
