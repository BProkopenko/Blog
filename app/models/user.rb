class User < ApplicationRecord
	has_many :posts, dependent: :destroy
	has_many :topics
	has_many :comments, dependent: :destroy
	attr_accessor :remember_token, :activation_token, :reset_token
	before_save :downcase_email
	before_create :create_activation_digest
	validates :name, presence: true, length: {maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 100},
	          format: {with: VALID_EMAIL_REGEX},
	          uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password, length: {minimum: 6}, allow_blank: true

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ?
				       BCrypt::Engine::MIN_COST :
				       BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	# Token for cookies
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	# Remember user
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# "True" if remember token == remember digest
	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest") # String interpolation
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	# Account activation
	def activate
		update_columns(activated: true, activated_at: Time.zone.now)
	end

	# Send activation link
	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end

	# Forget user
	def forget
		update_attribute(:remember_digest, nil)
	end

	# Define attributes for reset passwoord
	def create_reset_digest
		self.reset_token = User.new_token
		update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
	end

	# Send reset-password link to email
	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end

	# Returns true if the time to reset the password has expired.
	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end

	# Define Feed
	def feed
		Post.where("user_id = ?", id)
	end

	private

	# Change email to downcase
	def downcase_email
		self.email = email.downcase
	end

	def create_activation_digest
		self.activation_token = User.new_token
		#debugger
		self.activation_digest = User.digest(activation_token)
	end
end
