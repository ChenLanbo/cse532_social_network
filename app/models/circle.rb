class Circle < ActiveRecord::Base
	belongs_to :user
	has_many :circle_members, :dependent => :destroy
end
