class SummaryController < ApplicationController
	skip_before_filter :authorize
  def transaction
		@sales = Sale.all
  end

  def stat
		@user = nil
		@user_revenue = 0

		@ad = nil
		@ad_revenue = 0

		# Top User
		User.all.each do |u|
			# @sales = Sale.find_by_sql("SELECT sales.*, ads.unit_price FROM sales, advertisements AS ads WHERE sales.user_id = #{u.id} AND sales.advertisement_id = ads.id")
			# total = @sales.inject(0) {|sum, s| sum + s.quantity * s.unit_price}
			total = Sale.find_by_sql("SELECT sum(sales.quantity * ads.unit_price) AS sum FROM sales, advertisements AS ads WHERE sales.user_id = #{u.id} AND sales.advertisement_id = ads.id")[0].sum
			if total == nil
				next
			end
			@user, @user_revenue = u, total if @user_revenue < total
		end

		# Top Product
		Advertisement.all.each do |a|
			# @sales = Sale.find_by_sql("SELECT sales.*, ads.unit_price FROM sales, advertisements AS ads WHERE ads.id = #{a.id} AND sales.advertisement_id = ads.id")
			# total = @sales.inject(0) {|sum, s| sum + s.quantity * s.unit_price}
			total = Sale.find_by_sql("SELECT sum(sales.quantity * ads.unit_price) AS sum FROM sales, advertisements AS ads WHERE ads.id = #{a.id} AND sales.advertisement_id = ads.id")[0].sum
			if total == nil
				next
			end
			@ad, @ad_revenue = a, total if @ad_revenue < total
		end

		# Monthly stat
		if params[:year]
			# params[:year] = params[:year].to_i
			# params[:month] = params[:month].to_i
			st = params[:year] + '-' + params[:month] + '-01 00:00:00'
			et = params[:year] + '-' + params[:month] + '-31 23:23:23'
			@sales = Sale.find_by_sql("SELECT sales.*, ads.unit_price FROM sales, advertisements AS ads WHERE sales.advertisement_id = ads.id AND sales.created_at >= '#{st}' AND sales.created_at <= '#{et}'")
			# @sales = @sales.select do |s|
			#	s.created_at.year == params[:year] and s.created_at.month == params[:month]
			# end
			@monthly_revenue = @sales.inject(0) {|sum, s| sum + s.quantity * s.unit_price}
		else
			st = Time.now.year.to_s + '-' + Time.now.month.to_s + '-01 00:00:00'
			et = Time.now.year.to_s + '-' + Time.now.month.to_s + '-31 23:23:23'
			@sales = Sale.find_by_sql("SELECT sales.*, ads.unit_price FROM sales, advertisements AS ads WHERE sales.advertisement_id = ads.id AND sales.created_at >= '#{st}' AND sales.created_at <= '#{et}'")
			@monthly_revenue = @sales.inject(0) {|sum, s| sum + s.quantity * s.unit_price}
		end

		puts params[:ads]
		if params[:ads]
			@ads = Advertisement.find_by_sql("SELECT * FROM advertisements WHERE sold > 0 ORDER BY sold DESC")
		end

		respond_to do |format|
			format.html
			format.js
		end

  end

	def search
	end

	def query
		@res = -1
		@total = 0
		@trans = []

		# Query User
		if params[:first_name]
			@res = 0
			if params[:first_name].length == 0 or params[:last_name].length == 0
			else
				@trans = Sale.find_by_sql("SELECT sales.*, ads.unit_price, ads.item_name, ads.company FROM sales, users, advertisements AS ads WHERE users.first_name = '#{params[:first_name]}' and users.last_name = '#{params[:last_name]}' AND users.id = sales.user_id AND sales.advertisement_id = ads.id")
				@total = Sale.find_by_sql("SELECT sum(sales.quantity * ads.unit_price) AS sum FROM sales, users, advertisements AS ads WHERE users.first_name = '#{params[:first_name]}' and users.last_name = '#{params[:last_name]}' AND users.id = sales.user_id AND sales.advertisement_id = ads.id")[0].sum
				@total = 0 if @total == nil
			end

		# Query Item Name
		elsif params[:item_name]
			@res = 1
			if params[:item_name].length == 0
			else
				@ad = Advertisement.find_by_item_name(params[:item_name])
				if @ad != nil
					@trans = Sale.find_by_sql("SELECT sales.*, ads.unit_price, ads.item_name, ads.company FROM sales, advertisements AS ads WHERE sales.advertisement_id = ads.id AND ads.item_name = '#{params[:item_name]}'")
					@total = Sale.find_by_sql("SELECT sum(sales.quantity * ads.unit_price) AS sum FROM sales, advertisements AS ads WHERE sales.advertisement_id = ads.id AND ads.item_name = '#{params[:item_name]}'")[0].sum
					@total = 0 if @total == nil

					@users = User.find_by_sql("SELECT * FROM users WHERE id in (SELECT user_id FROM sales WHERE sales.advertisement_id = #{@ad.id})")
				else
					@trans, @users = [], []
				end
			end

		# Query Company
		elsif params[:company]
			@res = 2

			if params[:company].length == 0
			else
				@trans = Sale.find_by_sql("SELECT sales.*, ads.unit_price, ads.item_name, ads.company FROM sales, advertisements AS ads WHERE sales.advertisement_id = ads.id AND ads.company = '#{params[:company]}'")
				@ads = Advertisement.find_by_sql("SELECT * FROM advertisements AS ads WHERE ads.company = '#{params[:company]}' ORDER BY (ads.sold) DESC")
			end

		# Query Category
		elsif params[:type]
			@res = 3

			if params[:type].length != 0
				@trans = Sale.find_by_sql("SELECT sales.*, ads.unit_price, ads.item_name, ads.company FROM sales, advertisements AS ads WHERE sales.advertisement_id = ads.id AND ads.category = '#{params[:type]}'")
				@total = Sale.find_by_sql("SELECT sum(sales.quantity * ads.unit_price) AS sum FROM sales, advertisements AS ads WHERE sales.advertisement_id = ads.id AND ads.category = '#{params[:type]}'")[0].sum
				@total = 0 if @total == nil
			end

		else
		end

		respond_to do |format|
			format.js
		end
	end

end
