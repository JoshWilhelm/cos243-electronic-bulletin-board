class Board < ActiveRecord::Base
  attr_accessible :height, :name, :timezone, :width, :age
	attr_protected :user_id

	has_many :advertisements
	has_many :tiles, through: :advertisements
	belongs_to :user
	has_one :payment_detail, as: :payable

	validates_length_of :name, :minimum => 1
	validates :name, presence: true
	validates :timezone, presence: true
	validates :width, presence:  true,
		:numericality => { :greater_than_or_equal_to => 1 }
	validates :height, presence:  true,
		:numericality => { :greater_than_or_equal_to => 1 }
	validates :timezone, presence:  true
	validates_inclusion_of :timezone, :in => ActiveSupport::TimeZone.zones_map { |m| m.name }, :message => "is not a valid Time Zone"
	
	def age
	end
end
