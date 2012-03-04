class Page < ActiveRecord::Base
	has_many :posts, :dependent => :destroy

	validates :category, :presence => true
	validates :category, :inclusion => { :in => %w(user group), :message => "%{value} is not a valid value" }
	validates :owner, :presence => true
	validate :check_in_user_or_group

	private

	def check_in_user_or_group
		if category == 'user'
			errors.add(:category, 'No such user') unless User.find_by_id(owner)
		end
		if category == 'group'
			errors.add(:category, 'No such group') unless Group.find_by_id(owner)
		end
	end
end
