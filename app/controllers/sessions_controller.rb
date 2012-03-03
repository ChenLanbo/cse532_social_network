class SessionsController < ApplicationController
	skip_before_filter :authorize
  def new
  end

  def create
		if user = User.authenticate(params[:email], params[:password])
			session[:user_id] = user.id
			redirect_to users_url
		else
			redirect_to login_url, :notice => "Invalid email/password combination"
		end
  end

  def destroy
		session[:user_id] = nil
		redirect_to login_url, :notice => "Logged Out"
	end

end
