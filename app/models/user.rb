class User < ActiveRecord::Base
  attr_accessible :email, :name, :password_digest, :remember_token
	attr_protected :user_id, :admin

	has_many :boards
	has_many :advertisements
	has_many :payment_details

	validates :name, presence: true, length: { minimum: 1 }
	validates :email, presence: true
end
