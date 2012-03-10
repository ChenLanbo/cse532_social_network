class ManagementController < ApplicationController
	skip_before_filter :authorize

  def new
		if session[:manager_id]
			redirect_to '/management/index'
		end
  end

  def create
		if session[:manager_id]
			redirect_to '/management/index'
		end
		puts params[:account]
		puts params[:password]
		if params[:account] == 'abc' and params[:password] == 'abc'
			session[:manager_id] = 1
			redirect_to '/management/index'
		else
			redirect_to '/management/new'
		end
  end

  def destroy
		session[:manager_id] = nil
		redirect_to '/management/new'
  end

  def index
		check
  end

	protected
	
	def check
		unless session[:manager_id]
			redirect_to '/management/new', :notice => "Please Log In"
		end
	end

end
