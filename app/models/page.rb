class Page < ActiveRecord::Base
	has_many :posts, :dependent => :destroy

	validates :category, :presence => true
	validates :category, :inclusion => { :in => %w(user sip), :message => "%{value} is not a valid value" }
	validates :owner, :presence => true
	validate :check_in_user_or_sip

	private

	def check_in_user_or_sip
		if category == 'user'
			errors.add(:category, 'No such user or sip') unless User.find_by_id(owner)
		end
	end
end
