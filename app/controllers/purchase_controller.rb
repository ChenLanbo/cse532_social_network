class PurchaseController < ApplicationController
  def index
		@advertisements = []

		if Preference.where("user_id = #{session[:user_id]}")
			@advertisements = Advertisement.find_by_sql("SELECT a.* FROM advertisements AS a, preferences AS p WHERE a.quantity > 0 AND a.category = p.interest AND p.user_id = #{session[:user_id]} AND a.id NOT IN (SELECT advertisement_id FROM sales WHERE user_id = #{session[:user_id]})")
		else
			@advertisements = Advertisement.find_by_sql("SELECT * FROM advertisements WHERE quantity > 0 ORDER BY updated_at DESC LIMIT 20")
		end
  end

  def history
		@sales = Sale.find_by_sql("SELECT sales.*, ads.company, ads.item_name, ads.unit_price FROM sales, advertisements AS ads WHERE sales.user_id = #{session[:user_id]} AND sales.advertisement_id = ads.id ORDER BY sales.updated_at DESC")
  end

  def new
		@advertisement = Advertisement.find(params[:ad])
		respond_to do |format|
			format.js
		end
  end

  def create
		puts '-------------------'
		puts params[:ad_id]
		puts params[:user_id]
		puts params[:quantity]
		puts '-------------------'

		@sale = Sale.new
		@sale.advertisement_id = params[:ad_id]
		@sale.user_id = params[:user_id]
		@sale.quantity = params[:quantity]

		@sale.save

		@ad = Advertisement.find(params[:ad_id])
		q = @ad.quantity - @sale.quantity

		@ad.update_attributes(:quantity => q)

		redirect_to '/purchase/history'
  end

end
