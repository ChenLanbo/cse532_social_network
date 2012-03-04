class ApplicationController < ActionController::Base
	before_filter :authorize
  protect_from_forgery

	public

	protected

	def authorize
		# unless User.find_by_id(session[:user_id])
		unless session[:user_id]
			redirect_to login_url, :notice => "Please Log In"
		end	
	end

	def current_user
		if @current_user == nil
			@current_user = User.find_by_id(session[:user_id])
		end
		@current_user
	end

end
