class Group < ActiveRecord::Base
	belongs_to :user
	has_many :group_members, :dependent => :destroy
	has_many :group_requests, :dependent => :destroy

	def before_destroy
		@pages = Page.where(:category => 'group', :owner => id)
		puts "******************* " + @pages.length.to_s
		@pages.each do |p|
			p.destory
		end
	end
end
