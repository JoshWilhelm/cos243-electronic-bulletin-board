class User < ActiveRecord::Base
  attr_accessible :email, :name, :password_digest, :remember_token, :password, :password_confirmation
	attr_protected :user_id, :admin
	has_secure_password

	has_many :boards
	has_many :advertisements
	has_many :payment_details

	validates :name, presence: true, length: { minimum: 1 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
		validates :email, presence:   true,
			format:     { with: VALID_EMAIL_REGEX },
			uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }
	validates :password_confirmation, presence: true
end
