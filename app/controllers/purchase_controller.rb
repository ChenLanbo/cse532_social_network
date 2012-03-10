class PurchaseController < ApplicationController
  def index
		@advertisements = Advertisement.all
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

		redirect_to '/purchase/history'
  end

end
