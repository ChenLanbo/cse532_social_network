class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :page
	has_many :comments, :dependent => :destroy

	# validations
	validates :user_id, :page_id, :content, :presence => true
end
