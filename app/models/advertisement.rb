class Advertisement < ActiveRecord::Base
	validates :category, :company, :item_name, :unit_price, :quantity, :presence => true
	validates :unit_price, :numericality => {:greater_than => 0.0}
	validates :quantity, :numericality => {:greater_than_or_equal_to => 0}
end
