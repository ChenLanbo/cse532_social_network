class SummaryController < ApplicationController
	skip_before_filter :authorize
  def transaction
		@sales = Sale.all
  end

  def stat
  end

	def search
	end

	def query
		@res = -1
		@total = 0
		@trans = []

		if params[:first_name]
			@res = 0
			if params[:first_name].length == 0 or params[:last_name].length == 0
			else
				@trans = Sale.find_by_sql("SELECT sales.*, ads.unit_price, ads.item_name, ads.company FROM sales, users, advertisements AS ads WHERE users.first_name = '#{params[:first_name]}' and users.last_name = '#{params[:last_name]}' AND users.id = sales.user_id AND sales.advertisement_id = ads.id")
			end

		elsif params[:item_name]
			@res = 1
			if params[:item_name].length == 0
			else
				@trans = Sale.find_by_sql("SELECT sales.*, ads.unit_price, ads.item_name, ads.company FROM sales, advertisements AS ads WHERE sales.advertisement_id = ads.id AND ads.item_name = '#{params[:item_name]}'")
			end

		elsif params[:company]
			@res = 2

			if params[:company].length == 0
			else
				@trans = Sale.find_by_sql("SELECT sales.*, ads.unit_price, ads.item_name, ads.company FROM sales, advertisements AS ads WHERE sales.advertisement_id = ads.id AND ads.company = '#{params[:company]}'")
			end
		elsif params[:type]
			@res = 3

			if params[:type].length != 0
				@trans = Sale.find_by_sql("SELECT sales.*, ads.unit_price, ads.item_name, ads.company FROM sales, advertisements AS ads WHERE sales.advertisement_id = ads.id AND ads.category = '#{params[:type]}'")
			end

		else
		end

		@trans.each do |t|
			@total += t.quantity * t.unit_price
		end

		respond_to do |format|
			format.js
		end
	end

end
