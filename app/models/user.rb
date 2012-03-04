require 'digest/sha2'

class User < ActiveRecord::Base
	# Dependencies
	has_many :friends, :dependent => :destroy
	has_many :friends_requests, :dependent => :destroy
	has_many :circles, :dependent => :destroy
	has_many :circle_members, :dependent => :destroy
	has_many :groups, :dependent => :destroy
	has_many :group_members, :dependent => :destroy
	has_many :posts, :dependent => :destroy

	# Validations
	validates :first_name, :presence => true
	validates :last_name, :presence => true

	# Email
	validates :email, :presence => true, :uniqueness => true
	validates :email, :format => { :with => /[_a-z0-9]+(\.[_a-z0-9]+)*@[a-z0-9]+(\.[a-z0-9]+)*(\.[a-z]{2,4})/, :message => "%{value} is not a valid email address" }
	validates :email, :confirmation => true
	validates :email_confirmation, :presence => true

	validates :password, :confirmation => true
	attr_accessor :password_confirmation
	attr_reader :password
	validate :password_must_be_present

	def password=(password)
		@password = password
		if password.present?
			generate_salt
			self.hashed_password = self.class.encrypt_password(password, salt)
		end
	end

	def User.authenticate(email, password)
		# puts "*******************************" + password
		if email == "" or password == ""
			return nil
		end
		if user = find_by_email(email) and user.hashed_password == encrypt_password(password, user.salt)
			user
		else
			return nil
		end
	end

	def User.encrypt_password(password, salt)
		Digest::SHA2.hexdigest(password + "wibble" + salt)
	end

	private

	def password_must_be_present
		errors.add(:password, "Missing password") unless hashed_password.present?
	end

	def generate_salt
		self.salt = self.object_id.to_s + rand.to_s
	end

end
