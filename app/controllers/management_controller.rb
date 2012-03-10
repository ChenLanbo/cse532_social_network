class ManagementController < ApplicationController
	skip_before_filter :authorize

  def new
		check_login
  end

  def create
		check_login
		puts params[:account]
		puts params[:password]

		if params[:account] == 'abc' and params[:password] == 'abc'
			session[:manager_id] = 1
			redirect_to '/management/index'
		else
			redirect_to '/management/new'
		end
  end

  def delete
		check_logout
		session[:manager_id] = nil
		redirect_to '/management/new'
  end

  def index
		check_logout
		render
  end

	protected

	def check_login
		if session[:manager_id]
			redirect_to '/management/index'
		end
	end

	def check_logout
		unless session[:manager_id]
			redirect_to '/management/new'
		end
	end

end
